module MAbbre
  ##
  # Contains all compatibility patches that may be added to the environment depending on the current Ruby
  # version/implementation. This module won't be defined in an environment were no patches were applied.
  module Patch
    ##
    # Contains all patches related to the Object class. The methods contained within will only be defined if they are
    # needed.
    module ObjectMixin
      ##
      # call-seq:
      #   respond_to?(name, include_all = false) => true or false
      #
      # Passes +name+ and +include_all+ to +super+, and if +false+ is returned then #respond_to_missing? will be
      # called.
      #
      # Returns +true+ if this object responds to +name+, and +false+ otherwise.
      def respond_to?(name, include_all = false)
        super or respond_to_missing?(name, include_all)
      end

      private

      ##
      # call-seq:
      #   respond_to_missing?(name, include_all) => false
      #
      # This is used as the base implementation of #respond_to_missing?.
      #
      # Returns +false+ irregardless of the value of +name+ and +include_all+.
      def respond_to_missing?(_name, _include_all)
        false
      end
    end
  end
end
