# frozen_string_literal: true

require 'singleton'
require 'gifted/view_helpers'
require 'gifted/decorated'
require 'gifted/gift'

module Gifted
  class Decorator
    include Singleton

    def initialize
      @@decorators = {}
    end

    def decorate(obj)
      if obj.is_a?(Array)
        obj.each { |r| decorate r }
      elsif obj.is_a?(Hash)
        obj.each_value { |v| decorate v }
      elsif obj.is_a?(ActiveRecord::Relation)
        extend_with_relation_decorator obj
      else
        extend_with_decorated obj

        return obj unless (d = decorator_for(obj.class))

        # !! The original monkey patched code.
        # obj.extend d unless obj.is_a? d

        # The new hotness, which mixes in a single "parent" method called `gift`, that isolates all
        # decorated methods; avoiding confusion as to which methods are decorated and which are not.
        #
        # Example:
        #   object.gift.my_decorated_method
        #   object.my_non_decorated_method
        #
        # Instead of extending (decorating) the given object with the decorator module, this extends
        # it with Gifted::Gift, and sets the default decorator as the calculated decorator module
        # above. Gifted::Gift extends the object with one method; `gift`, which returns the
        # default decorator.
        obj.extend(::Gifted::Gift).default_decorator = d unless obj.is_a? ::Gifted::Gift
      end

      obj
    end

    # Decorates AR model object's association only when the object was decorated.
    # Returns the association instance.
    def decorate_association(owner, target)
      owner.is_a?(Gifted::Decorated) ? decorate(target) : target
    end

    private

      # Returns a decorator module for the given class.
      # Returns `nil` if no decorator module was found.
      def decorator_for(model_class)
        return @@decorators[model_class] if @@decorators.key? model_class

        decorator_name = "#{model_class.name}Decorator"
        d = Object.const_get decorator_name, false
        unless Class === d
          d.send :include, Gifted::ViewHelpers
          @@decorators[model_class] = d
        else
          # Cache nil results
          @@decorators[model_class] = nil
        end
      rescue NameError
        # This handles ActiveRecord STI models which don't have a decorator class - looking up it's
        # base class.

        if model_class.respond_to?(:base_class) && (model_class.base_class != model_class)
          @@decorators[model_class] = decorator_for model_class.base_class
        else
          # Cache nil results
          @@decorators[model_class] = nil
        end
      end

      def extend_with_relation_decorator(obj)
        return if obj.is_a? Gifted::RelationDecorator

        obj.extend Gifted::RelationDecorator
      end

      def extend_with_decorated(obj)
        return if !obj.is_a?(ActiveRecord::Base) || obj.is_a?(Gifted::Decorated)

        obj.extend Gifted::Decorated
      end
  end

  module RelationDecorator
    def records
      arr = super
      Gifted::Decorator.instance.decorate arr
      arr
    end
  end
end
