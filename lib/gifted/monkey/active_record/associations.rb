# frozen_string_literal: true

# A monkey-patch for Active Record that enables association auto-decoration.
module Gifted
  module Monkey
    module ActiveRecord
      module Associations
        module Association
          def target
            Gifted::Decorator.instance.decorate_association(owner, super)
          end
        end

        module CollectionProxy
          def take(*)
            Gifted::Decorator.instance.decorate_association(@association.owner, super)
          end

          def last(*)
            Gifted::Decorator.instance.decorate_association(@association.owner, super)
          end

          private

            def find_nth_with_limit(*)
              Gifted::Decorator.instance.decorate_association(@association.owner, super)
            end

            def find_nth_from_last(*)
              Gifted::Decorator.instance.decorate_association(@association.owner, super)
            end
        end

        module CollectionAssociation
          private

            def build_record(*)
              Gifted::Decorator.instance.decorate_association(@owner, super)
            end
        end
      end

      module AssociationRelation
        def take(*)
          Gifted::Decorator.instance.decorate_association(@association.owner, super)
        end

        private

          def find_nth_with_limit(*)
            Gifted::Decorator.instance.decorate_association(@association.owner, super)
          end

          def find_nth_from_last(*)
            Gifted::Decorator.instance.decorate_association(@association.owner, super)
          end
      end
    end
  end
end
