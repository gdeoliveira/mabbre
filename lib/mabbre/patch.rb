# This is only used for generating RDoc documentation. Don't run this.

if false # rubocop:disable Lint/LiteralInCondition
  module MAbbre
    ##
    # Contains all compatibility patches that may be added to the environment depending on the current Ruby
    # version/implementation. This module won't be defined in an environment were no patches were applied.
    module Patch
      ##
      # Contains all patches related to the Object class. The methods contained within will only be defined if they are
      # needed.
      module ObjectMixin
      end
    end
  end
end
