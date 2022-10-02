# frozen_string_literal: true

require 'test_helper'

class AssociationTest < ActiveSupport::TestCase
  test 'decorating associations' do
    a = Author.create! name: 'yugui'
    Gifted::Decorator.instance.decorate a

    b = a.books.build title: 'giraffe'
    assert b.is_a? Gifted::Decorated
    b = a.books.clear

    b = a.books.create! title: 'giraffe'
    assert b.is_a? Gifted::Decorated
    id = b.id

    b = a.books.first
    assert b.is_a? Gifted::Decorated

    b = a.books.last
    assert b.is_a? Gifted::Decorated

    b = a.books.find id
    assert b.is_a? Gifted::Decorated

    if ActiveRecord::VERSION::MAJOR >= 4
      b = a.books.take
      assert b.is_a? Gifted::Decorated
    end

    b = a.books.order(:id).first
    assert b.is_a? Gifted::Decorated

    b = a.books.order(:id).last
    assert b.is_a? Gifted::Decorated

    b = a.books.order(:id).find id
    assert b.is_a? Gifted::Decorated

    if ActiveRecord::VERSION::MAJOR >= 4
      b = a.books.order(:id).take
      assert b.is_a? Gifted::Decorated
    end
  end
end
