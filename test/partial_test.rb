# frozen_string_literal: true

require 'test_helper'

class PartialTest < ActionDispatch::IntegrationTest
  setup do
    Author.create! name: 'aamine'
    nari = Author.create! name: 'nari'
    nari.books.create! title: 'the gc book'
  end

  test 'decorating implicit @object' do
    get '/authors'

    assert_match 'the gc book', response.body
    assert_match 'the gc book'.reverse, response.body
  end

  test 'decorating implicit @collection' do
    get '/authors?partial=collection'

    assert_match 'the gc book', response.body
    assert_match 'the gc book'.reverse, response.body
  end

  test 'decorating objects in @locals' do
    get '/authors?partial=locals'

    assert_match 'the gc book', response.body
    assert_match 'the gc book'.upcase, response.body
  end
end
