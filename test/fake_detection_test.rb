# frozen_string_literal: true

require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test 'reveals fakes' do
    movie = Movie.create
    assert_nothing_raised { get "/movies/#{movie.id}" }
  end
end
