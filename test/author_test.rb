require './test/test_helper'
require './lib/author'
require './lib/book'

class AuthorTest < Minitest::Test
  def setup
    attributes = {
      first_name: 'Charlotte',
      last_name: 'Bronte'
    }
    @author = Author.new(attributes)
  end
  
  def test_author_exists
    assert_instance_of Author, @author
  end

  def test_author_has_first_name
    assert_equal 'Charlotte', @author.first_name
  end

  def test_author_has_last_name
    assert_equal 'Bronte', @author.last_name
  end

  def test_author_starts_without_books
    assert_equal [], @author.books
  end


  def test_format_date_with_full_date_string
    date = @author.format_date('September 24, 1993')
    assert_equal '09/24/1993', date
  end

  def test_format_date_with_only_year
    date = @author.format_date('1993')
    assert_equal '1993', date
  end

  def test_new_book_can_be_created_by_author
    new_book = @author.add_book('Jane Eyre', 'October 16, 1847')
    assert_instance_of Book, new_book
    assert_equal 'Charlotte', new_book.author_first_name
    assert_equal 'Bronte', new_book.author_last_name
    assert_equal 'Jane Eyre', new_book.title
    assert_equal '10/16/1847', new_book.publication_date
  end

  def test_new_book_can_be_added_to_author
    @author.add_book('Jane Eyre', 'October 16, 1847')

    assert_instance_of Book, @author.books[0]
    assert_equal 'Charlotte', @author.books[0].author_first_name
    assert_equal 'Bronte', @author.books[0].author_last_name
    assert_equal 'Jane Eyre', @author.books[0].title
    assert_equal '10/16/1847', @author.books[0].publication_date
  end

  def test_another_new_book_can_be_created
    new_book = @author.add_book('Villette', '1853')
    assert_instance_of Book, new_book
    assert_equal 'Charlotte', new_book.author_first_name
    assert_equal 'Bronte', new_book.author_last_name
    assert_equal 'Villette', new_book.title
    assert_equal '1853', new_book.publication_date
  end

  def test_another_new_book_can_be_added_to_author
    @author.add_book('Jane Eyre', 'October 16, 1847')
    @author.add_book('Villette', '1853')

    assert_instance_of Book, @author.books[0]
    assert_equal 'Charlotte', @author.books[0].author_first_name
    assert_equal 'Bronte', @author.books[0].author_last_name
    assert_equal 'Jane Eyre', @author.books[0].title
    assert_equal '10/16/1847', @author.books[0].publication_date

    assert_instance_of Book, @author.books[1]
    assert_equal 'Charlotte', @author.books[1].author_first_name
    assert_equal 'Bronte', @author.books[1].author_last_name
    assert_equal 'Villette', @author.books[1].title
    assert_equal '1853', @author.books[1].publication_date

    assert_equal 2, @author.books.length
  end


end

# Fix publication date formatting
