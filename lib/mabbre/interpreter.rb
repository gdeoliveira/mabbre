module MAbbre
  ##
  # This module is added to the method lookup path and interprets abbreviations for tracked methods.
  module Interpreter
    private

    ##
    # call-seq:
    #   method_missing(name, *args)
    #
    # If a suitable candidate for abbreviation +name+ is found it will be called using +args+. Otherwise it will let
    # +super+ handle the missing method.
    def method_missing(name, *args)
      matched = nil

      if self.class.tracked_methods(MAbbre).one? {|m| matched = m if m.to_s =~ /\A#{name}/ }
        send(matched, *args)
      else
        super
      end
    end

    ##
    # call-seq:
    #   respond_to_missing?(name, include_all) => true or false
    #
    # Checks if this object responds to abbreviation +name+. The +include_all+ parameter is not used but it will
    # be passed to +super+ if no suitable candidate is found.
    #
    # Returns +true+ if this object responds to +name+, or whatever +super+ returns otherwise.
    def respond_to_missing?(name, include_all)
      self.class.tracked_methods(MAbbre).one? {|m| m.to_s =~ /\A#{name}/ } or super
    end
  end
end
