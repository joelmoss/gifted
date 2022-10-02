# frozen_string_literal: true

require 'test_helper'

class AssociationIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    company = Company.create! name: 'NaCl'
    @matz = company.authors.create! name: 'matz'
    @matz.books.create!(
      title: 'the world of code',
      publisher_attributes: { name: 'nikkei linux' }
    )
    @matz.books.create!(
      title: 'the ruby programming language',
      publisher_attributes: { name: "o'reilly" }
    )
    @matz.create_profile! address: 'Matsue city, Shimane'
    @matz.profile.create_profile_history! updated_on: Date.new(2017, 2, 7)
    @matz.magazines.create! title: 'rubima'
  end

  test 'decorating associated objects' do
    get "/authors/#{@matz.id}"

    assert_match 'the world of code'.upcase, response.body
    assert_match 'the ruby programming language'.upcase, response.body

    assert_match 'nikkei linux'.upcase, response.body if Rails.version.to_f >= 4.0
    assert_match 'nikkei linux'.reverse, response.body if Rails.version.to_f >= 5.1

    assert_match 'secret', response.body
    assert_match '2017/02/07', response.body
    assert_match 'rubima'.upcase, response.body
    assert_match 'NaCl'.reverse, response.body
  end

  test "decorating associated objects that owner doesn't have decorator" do
    movie = Movie.create! author: @matz
    get "/movies/#{movie.id}"

    assert_match 'matz'.reverse, response.body
  end
end
