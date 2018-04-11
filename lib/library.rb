class Library
  attr_reader :books

  def initialize
    @books = []
  end

  def add_to_collection(book)
    @books << book
  end

  def include?(title)
    all_titles = @books.map(&:title)
    all_titles.include?(title)
  end

  def card_catalogue
    @books.sort_by { |book| book.author_last_name }
  end
end
