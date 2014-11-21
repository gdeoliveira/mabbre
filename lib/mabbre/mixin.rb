require "mtrack"
require "mabbre/extension"

module MAbbre
  ##
  # This module provides the #allow_abbreviated method to Classes or Modules that extend it.
  module Mixin
    include MTrack::Mixin
    extend Extension

    private

    ##
    # call-seq:
    #   allow_abbreviated() => set
    #   allow_abbreviated() {|| ... } => set
    #
    # If a block is provided all the methods defined within the block will be accessible by using a shortened version of
    # their name as long as no abiguities are found between them.
    #
    # Returns a set containing the methods that were defined within the block.
    #
    #   class C
    #     extend MAbbre::Mixin
    #     allow_abbreviated do
    #       def long_method; end
    #       def longer_method; end
    #       def longest_method; end
    #     end
    #   end  #=> #<Set: {:long_method, :longer_method, :longest_method}>
    def allow_abbreviated(&b)
      track_methods(MAbbre, &b)
    end

    ##
    # call-seq:
    #   included(submodule) => submodule
    #
    # Adds the #allow_abbreviated method to +submodule+ by extending Mixin.
    #
    # Returns passed +submodule+.
    def included(submodule)
      super
      submodule.instance_eval { extend Mixin }
      submodule
    end
  end
end
