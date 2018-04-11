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

  def find_by_author(author_full_name)
    first_name = author_full_name.split[0]
    last_name = author_full_name.split[1]
    result = @books.each.group_by do |book|
      if book.author_first_name == first_name || book.author_last_name == last_name
        book.title
      end
    end
    result.delete(nil)
    result.each do |title, book_array|
      result[title] = book_array[0]
    end
  end

  def find_by_publication_date(date)
    result = @books.group_by do |book|
      if book.publication_date == date
        book.title
      end
    end
    result.delete(nil)
    result.each do |title, book_array|
      result[title] = book_array[0]
    end
  end
end
