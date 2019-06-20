# frozen_string_literal: true

# A monkey-patch for Action Controller to pass the controller view_context over
# to `render` invocation in `rescue_from` block.
module Gifted
  module Monkey
    module ActionController
      module Base
        def rescue_with_handler(*)
          Gifted::ViewContext.push(view_context)
          super
        ensure
          Gifted::ViewContext.pop
        end
      end
    end
  end
end
