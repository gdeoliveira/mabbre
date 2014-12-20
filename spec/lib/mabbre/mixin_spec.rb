require "spec_helper"

METHOD_DEFINITION = proc { __method__ }

describe MAbbre::Mixin do
  describe "#allow_abbreviated" do
    it "is added after extending #{described_class}" do
      mod = ::Module.new
      expect(mod.private_methods).not_to include(:allow_abbreviated)
      mod.module_eval { extend MAbbre::Mixin }
      expect(mod.private_methods).to include(:allow_abbreviated)
    end

    context "block given" do
      it "returns a set with the methods that can be abbreviated" do
        mod = ::Module.new.module_eval do
          extend MAbbre::Mixin
          allow_abbreviated do
            define_method :qwe, &METHOD_DEFINITION
            define_method :asd, &METHOD_DEFINITION
            define_method :zxc, &METHOD_DEFINITION
          end
        end
        expect(mod).to be_a(Set)
        expect(mod).to match_array([:qwe, :asd, :zxc])
      end
    end

    context "no block given" do
      it "returns an empty set" do
        mod = ::Module.new.module_eval do
          extend MAbbre::Mixin
          allow_abbreviated
        end
        expect(mod).to be_a(Set)
        expect(mod).to be_empty
      end
    end
  end

  describe "hierarchy" do
    let(:base_extension) do
      Module.new.tap do |m|
        m.module_eval do
          include MAbbre::Mixin
          define_method :base_extension_meth, &METHOD_DEFINITION
        end
      end
    end

    let(:sub_extension) do
      be = base_extension
      Module.new.tap do |m|
        m.module_eval do
          include be
          define_method :sub_extension_meth, &METHOD_DEFINITION
        end
      end
    end

    let(:base_module) do
      se = sub_extension
      Module.new.tap do |m|
        m.module_eval do
          extend se
          define_method :meth_00_extra, &METHOD_DEFINITION
          allow_abbreviated do
            define_method :meth_01_extra, &METHOD_DEFINITION
            define_method :meth_02_extra, &METHOD_DEFINITION
            define_method :meth_03_extra, &METHOD_DEFINITION
          end
          define_method :meth_09_extra, &METHOD_DEFINITION
        end
      end
    end

    let(:sub_module) do
      bm = base_module
      Module.new.tap do |m|
        m.module_eval do
          include bm
          define_method :meth_10_extra, &METHOD_DEFINITION
          allow_abbreviated do
            define_method :meth_11_extra, &METHOD_DEFINITION
            define_method :meth_12_extra, &METHOD_DEFINITION
            define_method :meth_13_extra, &METHOD_DEFINITION
          end
          define_method :meth_19_extra, &METHOD_DEFINITION
        end
      end
    end

    let(:super_class) do
      sm = sub_module
      Class.new.tap do |c|
        c.class_eval do
          include sm
          define_method :meth_20_extra, &METHOD_DEFINITION
          allow_abbreviated do
            define_method :meth_21_extra, &METHOD_DEFINITION
            define_method :meth_22_extra, &METHOD_DEFINITION
            define_method :meth_23_extra, &METHOD_DEFINITION
          end
          define_method :meth_29_extra, &METHOD_DEFINITION
        end
      end
    end

    let(:sub_class) do
      sc = super_class
      Class.new(sc).tap do |c|
        c.class_eval do
          define_method :meth_30_extra, &METHOD_DEFINITION
          allow_abbreviated do
            define_method :meth_31_extra, &METHOD_DEFINITION
            define_method :meth_32_extra, &METHOD_DEFINITION
            define_method :meth_33_extra, &METHOD_DEFINITION
          end
          define_method :meth_39_extra, &METHOD_DEFINITION
        end
      end
    end

    context "base module" do
      subject { base_module }

      it "has custom extensions as ancestors" do
        expect(subject.singleton_methods).to include(:base_extension_meth, :sub_extension_meth)
      end

      it "tracks methods that can be abbreviated" do
        expect(subject.tracked_methods(MAbbre)).to match_array([:meth_01_extra, :meth_02_extra, :meth_03_extra])
      end
    end

    context "sub module" do
      subject { sub_module }

      it "tracks methods that can be abbreviated" do
        expect(subject.tracked_methods(MAbbre)).to match_array([:meth_01_extra, :meth_02_extra, :meth_03_extra,
                                                                :meth_11_extra, :meth_12_extra, :meth_13_extra])
      end
    end

    context "super class" do
      subject { super_class }

      it "tracks methods that can be abbreviated" do
        expect(subject.tracked_methods(MAbbre)).to match_array([:meth_01_extra, :meth_02_extra, :meth_03_extra,
                                                                :meth_11_extra, :meth_12_extra, :meth_13_extra,
                                                                :meth_21_extra, :meth_22_extra, :meth_23_extra])
      end
    end

    context "sub class" do
      subject { sub_class }

      it "tracks methods that can be abbreviated" do
        expect(subject.tracked_methods(MAbbre)).to match_array([:meth_01_extra, :meth_02_extra, :meth_03_extra,
                                                                :meth_11_extra, :meth_12_extra, :meth_13_extra,
                                                                :meth_21_extra, :meth_22_extra, :meth_23_extra,
                                                                :meth_31_extra, :meth_32_extra, :meth_33_extra])
      end

      describe "instance" do
        subject { sub_class.new }

        it { should_not respond_to(:meth, :meth_0, :meth_1, :meth_2, :meth_3) }

        it "avoids calling ambiguous methods" do
          expect { subject.meth }.to raise_error(NoMethodError)
          expect { subject.meth_0 }.to raise_error(NoMethodError)
          expect { subject.meth_1 }.to raise_error(NoMethodError)
          expect { subject.meth_2 }.to raise_error(NoMethodError)
          expect { subject.meth_3 }.to raise_error(NoMethodError)
        end

        it { should respond_to(:meth_01, :meth_12, :meth_23, :meth_31) }

        it "calls resolvable methods that can be abbreviated" do
          expect(subject.meth_02).to be(:meth_02_extra)
          expect(subject.meth_13).to be(:meth_13_extra)
          expect(subject.meth_21).to be(:meth_21_extra)
          expect(subject.meth_32).to be(:meth_32_extra)
        end

        it { should_not respond_to(:meth_00, :meth_10, :meth_20, :meth_30) }

        it "avoids calling resolvable methods that can't be abbreviated" do
          expect { subject.meth_09 }.to raise_error(NoMethodError)
          expect { subject.meth_19 }.to raise_error(NoMethodError)
          expect { subject.meth_29 }.to raise_error(NoMethodError)
          expect { subject.meth_39 }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
