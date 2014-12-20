module MAbbre # rubocop:disable Style/Documentation
  ##
  # This is a temporary module that is run when loading MAbbre in order to add patches on some Ruby
  # versions/implementations. After the environment is patched it will be automatically removed.
  module Compatibility
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
        OBJECT_PATCHES.each {|patch, needed| require "#{PATH_TO_OBJECT_PATCHES}/#{patch}" if needed }
        Object.instance_eval { include Patch::ObjectMixin } if OBJECT_PATCHES.values.any?
      end
    end

    ##
    # Relative path to the directory where patch files for the Object class live.
    PATH_TO_OBJECT_PATCHES = "mabbre/patch/object_mixin".freeze

    ##
    # A hash of patch names for the Object class. Each patch name has a +true+ or +false+ value assigned that represents
    # if they need to be applied or not.
    OBJECT_PATCHES = {
      respond_to_missing: !Object.private_instance_methods.map(&:to_sym).include?(:respond_to_missing?)
    }.freeze

    init_self
  end

  remove_const :Compatibility
end
