require './test/test_helper'
require './lib/book'

class BookTest < Minitest::Test
  def setup
    attributes = {
      author_first_name: 'Harper',
      author_last_name: 'Lee',
      title: 'To Kill a Mockingbird',
      publication_date: 'July 11, 1960' }
    @book = Book.new(attributes)
  end

  def test_book_exists
    assert_instance_of Book, @book
  end

  def test_book_has_author_first_name
    assert_equal 'Harper', @book.author_first_name
  end

  def test_book_has_author_last_name
    assert_equal 'Lee', @book.author_last_name
  end

  def test_book_has_title
    assert_equal 'To Kill a Mockingbird', @book.title
  end

  def test_book_has_publication_date
    assert_equal 'July 11, 1960', @book.publication_date
  end
end
