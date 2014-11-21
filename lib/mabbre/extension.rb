require "mabbre/interpreter"

module MAbbre
  ##
  # This module is extended by MAbbre::Mixin and all custom extensions of MAbbre::Mixin. You should not extend this
  # module directly, instead simply include MAbbre::Mixin into your custom extension:
  #
  #   module MyExtension
  #     include MAbbre::Mixin
  #     # Define custom methods here.
  #   end
  #
  #   module M
  #     extend MyExtension
  #     # You can use MAbbre's and MyExtension's methods here.
  #   end
  #
  # If you're overriding the +extended+ or +included+ methods in your custom extension always make sure to call +super+,
  # so MAbbre can be properly initialized.
  module Extension
    private

    ##
    # call-seq:
    #   extended(submodule) => submodule
    #
    # Includes MAbbre::Interpreter in +submodule+ (the Class or Module that extended MAbbre::Mixin).
    #
    # Returns passed +submodule+.
    def extended(submodule)
      super
      submodule.instance_eval { include Interpreter }
      submodule
    end

    ##
    # call-seq:
    #   included(submodule) => submodule
    #
    # Initializes +submodule+ as a custom extension of MAbbre::Mixin. The new custom extension +submodule+ can then be
    # extended by a Class or Module just like MAbbre::Mixin, or included further to generate other, more specific custom
    # extensions.
    #
    # Returns passed +submodule+.
    def included(submodule)
      super
      submodule.instance_eval { extend Extension }
      submodule
    end
  end
end
