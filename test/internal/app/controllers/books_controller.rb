class BooksController < ActionController::Base
  class CustomError < StandardError; end

  rescue_from CustomError do
    render :error
  end

  def index
    @author = Author.find params[:author_id]
    @books  = @author.books
  end

  def show
    @name = 'Joel'
    @book = Author.find(params[:author_id]).books.find(params[:id])
  end

  def errata
    @book = Author.find(params[:author_id]).books.find(params[:id])
  end

  def errata2
    @book = Author.find(params[:author_id]).books.find(params[:id])
  end

  def error
    @book = Author.find(params[:author_id]).books.find(params[:id])
    raise CustomError, 'error'
  end

  def purchase
    @book = Author.find(params[:author_id]).books.find(params[:id])

    @view_context_before_sending_mail = Gifted::ViewContext.current
    BookMailer.thanks(@book).deliver
    raise 'Wrong ViewContext!' if Gifted::ViewContext.current != @view_context_before_sending_mail
  end
end
