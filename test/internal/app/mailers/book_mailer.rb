class BookMailer < ActionMailer::Base
  def thanks(book)
    @book = book
    mail from: 'nobody@example.com', to: 'test@example.com', subject: 'Thanks'
  end
end
