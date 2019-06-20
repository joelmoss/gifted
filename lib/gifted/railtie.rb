# frozen_string_literal: true

require 'rails'

module Gifted
  class Railtie < ::Rails::Railtie
    initializer 'gifted' do
      ActiveSupport.on_load :action_view do
        require 'gifted/monkey/action_view/partial_renderer'
        ActionView::PartialRenderer.send :prepend, Gifted::Monkey::ActionView::PartialRenderer
      end

      ActiveSupport.on_load :action_controller do
        require 'gifted/monkey/abstract_controller/rendering'
        ActionController::Base.send :prepend, Gifted::Monkey::AbstractController::Rendering

        require 'gifted/monkey/action_controller/base/rescue_from'
        ActionController::Base.send :prepend, Gifted::Monkey::ActionController::Base

        require 'gifted/view_context'
        ActionController::Base.send :include, Gifted::ViewContext::Filter
      end

      ActiveSupport.on_load :action_mailer do
        require 'gifted/monkey/abstract_controller/rendering'
        ActionMailer::Base.send :prepend, Gifted::Monkey::AbstractController::Rendering

        if ActionMailer::Base.respond_to? :before_action
          require 'gifted/view_context'
          ActionMailer::Base.send :include, Gifted::ViewContext::Filter
        end
      end

      ActiveSupport.on_load :active_record do
        require 'gifted/monkey/active_record/associations'

        ActiveRecord::Associations::Association.send :prepend, Gifted::Monkey::ActiveRecord::Associations::Association
        ActiveRecord::AssociationRelation.send :prepend, Gifted::Monkey::ActiveRecord::AssociationRelation
        ActiveRecord::Associations::CollectionProxy.send :prepend, Gifted::Monkey::ActiveRecord::Associations::CollectionProxy
        ActiveRecord::Associations::CollectionAssociation.send :prepend, Gifted::Monkey::ActiveRecord::Associations::CollectionAssociation
      end
    end
  end
end
