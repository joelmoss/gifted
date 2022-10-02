# frozen_string_literal: true

require 'test_helper'

class DecoratorTest < ActiveSupport::TestCase
  test 'it returns the object on decoration' do
    book = Book.new title: 'Boek'
    assert_equal book, Gifted::Decorator.instance.decorate(book)
  end

  test 'it returns the object when it already is decorated on decorate' do
    book = Book.new title: 'Boek'
    assert_equal book, Gifted::Decorator.instance.decorate(Gifted::Decorator.instance.decorate(book))
  end

  test 'it returns the object of ActiveRecord::Relation on decorate' do
    3.times do |index|
      Book.create title: "ve#{index}"
    end

    books = Book.all
    assert_equal books, Gifted::Decorator.instance.decorate(books)
  end

  test 'it returns the object of ActiveRecord::Relation when it already is decorated on decorate' do
    3.times do |index|
      Book.create title: "ve#{index}"
    end

    books = Book.all
    assert_equal books, Gifted::Decorator.instance.decorate(Gifted::Decorator.instance.decorate(books))
  end

  test 'decorating Array decorates its each element' do
    array = [Book.new(title: 'Boek')]
    assert_equal array, Gifted::Decorator.instance.decorate(array)

    array.each do |value|
      assert value.gift.is_a?(BookDecorator)
    end
  end

  test 'decorating Hash decorates its each value' do
    hash = { some_record: Book.new(title: 'Boek') }
    assert_equal hash, Gifted::Decorator.instance.decorate(hash)

    hash.values.each do |value|
      assert value.gift.is_a?(BookDecorator)
    end
  end
end
