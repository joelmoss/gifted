# frozen_string_literal: true

module Gifted
  module ViewHelpers
    def method_missing(method_name, *args, &block)
      view_context = Gifted::ViewContext.current
      view_context&.respond_to?(method_name) ? view_context.send(method_name, *args, &block) : super
    end

    def respond_to_missing?(method_name, *args)
      Gifted::ViewContext.current.respond_to?(method_name) || super
    end

    def controller
      @controller ||= Gifted::ViewContext.current.instance_variable_get(:@_controller)
    end
  end
end
