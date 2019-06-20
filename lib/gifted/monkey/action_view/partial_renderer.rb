# frozen_string_literal: true

# A monkey-patch for Action View `render :partial` that auto-decorates `locals` values.
module Gifted
  module Monkey
    module ActionView
      module PartialRenderer
        private

        def setup(*)
          super

          @locals.each_value do |v|
            Gifted::Decorator.instance.decorate v
          end if @locals
          Gifted::Decorator.instance.decorate @object if @object
          Gifted::Decorator.instance.decorate @collection unless @collection.blank?

          self
        end
      end
    end
  end
end
