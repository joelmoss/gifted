class MoviesController < ActionController::Base
  def show
    @movie = Movie.find params[:id]
  end
end
