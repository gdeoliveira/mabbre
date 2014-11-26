module MAbbre
  module Compatibility
    ##
    # This module holds constants used by MAbbre::Compatibility
    module Constants
      ##
      # Relative path to the directory where patch files for the Object class live.
      PATH_TO_OBJECT_PATCHES = "mabbre/patch/object_mixin".freeze

      ##
      # A hash of patch names for the Object class. Each patch name has a +true+ or +false+ value assigned that
      # represents if they need to be applied or not.
      OBJECT_PATCHES = {
        :respond_to_missing => !Object.private_instance_methods.map(&:to_sym).include?(:respond_to_missing?)
      }.freeze
    end
  end
end
