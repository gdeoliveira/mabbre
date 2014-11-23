require "mabbre/patch"

module MAbbre
  ##
  # This is a temporary module that is run when loading MAbbre in order to add patches on some Ruby
  # versions/implementations. After the environment is patched it will be automatically removed.
  module Compatibility
    ##
    # Relative path to the directory where patch files for the Object class live.
    PATH_TO_OBJECT_PATCHES = "mabbre/patch/object_mixin".freeze

    ##
    # An array of patch names for the Object class.
    OBJECT_PATCHES = [:respond_to_missing].freeze

    class << self
      private

      ##
      # call-seq:
      #   init_self() => nil
      #
      # This method is automatically called by this module in order to apply all patches.
      #
      # Returns a +nil+ value.
      def init_self
        check_object
        nil
      end

      ##
      # call-seq:
      #   check_object() => Object or nil
      #
      # Checks all available patches for the Object class and applies the ones that are needed.
      #
      # Returns Object if patches were applied or +nil+ otherwise.
      def check_object
        OBJECT_PATCHES.each {|p| require "#{PATH_TO_OBJECT_PATCHES}/#{p}" }
        Object.instance_eval { include Patch::ObjectMixin } if defined? Patch::ObjectMixin
      end
    end

    init_self
  end

  remove_const :Compatibility
end
