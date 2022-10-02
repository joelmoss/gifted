# frozen_string_literal: true

require 'test_helper'

class ControllerIvarTest < ActionDispatch::IntegrationTest
  setup do
    @matz = Author.create! name: 'matz'
    @matz.books.create! title: 'the world of code'
    Author.create! name: 'takahashim'
  end

  test 'decorating a model object in ivar' do
    get "/authors/#{@matz.id}"

    assert_match 'matz', response.body
    assert_match 'matz'.capitalize, response.body
  end

  test 'decorating model scope in ivar with a view' do
    get '/authors'

    assert_match 'takahashim (admin)', response.body
  end

  test 'decorating model scope in ivar' do
    get '/authors'

    assert_match 'takahashim', response.body
    assert_match 'takahashim'.reverse, response.body
  end

  test "decorating models' array in ivar" do
    get '/authors?variable_type=array'

    assert_match 'takahashim', response.body
    assert_match 'takahashim'.reverse, response.body
  end

  test "decorating models' proxy object in ivar" do
    get '/authors?variable_type=proxy'

    assert_match 'takahashim', response.body
    assert_match 'takahashim'.reverse, response.body
  end

  test 'decorating model association proxy in ivar' do
    get "/authors/#{@matz.id}/books"

    assert_match 'the world of code', response.body
    assert_match 'the world of code'.reverse, response.body
  end
end
