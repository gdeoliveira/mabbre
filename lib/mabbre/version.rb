##
# MAbbre allows a group of methods in a Class or a Module to be accessed using an abbreviated form. These methods can
# be defined anywhere within a hierarchy of inclusion and/or inheritance.
#
#    module M
#      extend MAbbre::Mixin
#      allow_abbreviated do
#        def very_long_method
#          "This method has a very long name."
#        end
#      end
#    end
#
#    class C
#      include M
#      allow_abbreviated do
#        def another_long_method
#          "Another method with a long name."
#        end
#      end
#    end
#
#    class D < C
#      allow_abbreviated do
#        def yet_another_long_method
#          "Yet another looong method name."
#        end
#      end
#    end
#
#    o = D.new
#    o.very     #=> "This method has a very long name."
#    o.another  #=> "Another method with a long name."
#    o.yet      #=> "Yet another looong method name."
module MAbbre
  ##
  # Current version of MAbbre.
  VERSION = "1.0.2"
end
