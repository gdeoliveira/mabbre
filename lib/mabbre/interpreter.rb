module MAbbre
  ##
  # TODO: Add documentation.
  module Interpreter
    private

    def method_missing(name, *args)
      matched = nil
      if self.class.tracked_methods(MAbbre).one? {|m| matched = m if m.to_s =~ /\A#{name}/ }
        send(matched, *args)
      else
        super
      end
    end
  end
end
