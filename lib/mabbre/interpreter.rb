module MAbbre
  ##
  # This module is added to the method lookup path and interprets abbreviations for tracked methods.
  module Interpreter
    private

    ##
    # call-seq:
    #   method_missing(name, *args) => name
    #
    # If a suitable candidate for abbreviation +name+ is found it will be called using +args+. Otherwise it will let
    # +super+ handle the missing method.
    #
    # Returns passed +name+.
    def method_missing(name, *args)
      matched = nil

      if self.class.tracked_methods(MAbbre).one? {|m| matched = m if m.to_s =~ /\A#{name}/ }
        send(matched, *args)
      else
        super
      end

      name
    end
  end
end
