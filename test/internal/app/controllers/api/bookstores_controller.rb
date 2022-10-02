class Api::BookstoresController < ActionController::API
  def show
    @bookstore = Bookstore.find params[:id]
  end
end
