require "mabbre/interpreter"

module MAbbre
  ##
  # TODO: Add documentation.
  module Extension
    private

    def extended(submodule)
      super
      submodule.instance_eval { include Interpreter }
      submodule
    end

    def included(submodule)
      super
      submodule.instance_eval { extend Extension }
      submodule
    end
  end
end
