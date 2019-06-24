# frozen_string_literal: true

module Gifted
  module Gift
    attr_accessor :default_decorator

    def gift(view = nil)
      @decorator_views ||= { default: gift_delegator }

      if view
        @decorator_views[view] ||= gift_delegator(view)
      else
        @decorator_views[:default]
      end
    end

    private

      def gift_delegator(view = nil)
        decorator = default_decorator

        if view
          decorator = default_decorator.const_get("#{view.to_s.camelcase}Decorator")
          decorator.send :include, Gifted::ViewHelpers unless decorator.is_a?(Class)
        end

        SimpleDelegator.new(self).extend decorator
      end
  end
end
