require './lib/book'

class Author
  attr_reader :first_name,
              :last_name,
              :books

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @books = []
  end

  def add_book(title, publication_date)
    new_book_attributes = {
      title: title,
      publication_date: publication_date,
      author_first_name: @first_name,
      author_last_name: @last_name }
      new_book = Book.new(new_book_attributes)
    @books << new_book
    new_book
  end
end
