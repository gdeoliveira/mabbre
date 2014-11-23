require "spec_helper"
require "mabbre/patch/object_mixin/respond_to_missing"

describe MAbbre::Patch::ObjectMixin do
  subject do
    dc = described_class
    Class.new.instance_eval { include dc }.new
  end

  describe "#respond_to?" do
    it "calls #respond_to_missing? at least once" do
      expect(subject).to receive(:respond_to_missing?).with(:test_method, false).at_least(:once)
      subject.respond_to? :test_method
    end

    it "calls #respond_to_missing? at most twice" do
      expect(subject).to receive(:respond_to_missing?).with(:test_method, false).at_most(:twice)
      subject.respond_to? :test_method
    end
  end

  describe "#respond_to_missing?" do
    it "returns false" do
      expect(subject.send(:respond_to_missing?, :test_method, true)).to be(false)
    end
  end
end
