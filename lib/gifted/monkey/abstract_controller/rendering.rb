# frozen_string_literal: true

# A monkey-patch for Rails controllers/mailers that auto-decorates ivars
# that are passed to views.
module Gifted
  module Monkey
    module AbstractController
      module Rendering
        def view_assigns
          hash = super
          hash.each_value do |v|
            Gifted::Decorator.instance.decorate v
          end
          hash
        end
      end
    end
  end
end
