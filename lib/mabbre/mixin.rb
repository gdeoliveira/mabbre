require "mtrack"
require "mabbre/extension"

module MAbbre
  ##
  # TODO: Add documentation.
  module Mixin
    include MTrack::Mixin
    extend Extension

    private

    def allow_abbreviated(&b)
      track_methods(MAbbre, &b)
    end

    def included(submodule)
      super
      submodule.instance_eval { extend Mixin }
      submodule
    end
  end
end
