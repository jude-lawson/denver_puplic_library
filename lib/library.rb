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
  
end
