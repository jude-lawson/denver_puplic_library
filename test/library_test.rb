require './test/test_helper'
require './lib/library'
require './lib/author'

class LibraryTest < Minitest::Test
  def setup
    @dpl = Library.new
    @charlotte_bronte = Author.new({first_name: 'Charlotte', last_name: 'Bronte'})
    @jane_eyre = @charlotte_bronte.add_book('Jane Eyre', 'October 16, 1847')
    @villette  = @charlotte_bronte.add_book('Villette', '1853')

    @harper_lee  = Author.new({first_name: 'Harper', last_name: 'Lee'})
    @mockingbird = @harper_lee.add_book('To Kill a Mockingbird', 'July 11, 1960')
  end

  def test_library_exists
    assert_instance_of Library, @dpl
  end

  def test_library_starts_with_no_books
    assert_equal [], @dpl.books
  end

  def test_one_book_can_be_added_to_collection
    @dpl.add_to_collection(@jane_eyre)
    assert_instance_of Book, @dpl.books[0]
    assert_equal 'Charlotte', @dpl.books[0].author_first_name
    assert_equal 'Bronte', @dpl.books[0].author_last_name
    assert_equal 'Jane Eyre', @dpl.books[0].title
    assert_equal '10/16/1847', @dpl.books[0].publication_date
  end

  def test_multiple_books_can_be_added
    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(@mockingbird)
    @dpl.add_to_collection(@villette)

    assert_instance_of Book, @dpl.books[0]
    assert_equal 'Charlotte', @dpl.books[0].author_first_name
    assert_equal 'Bronte', @dpl.books[0].author_last_name
    assert_equal 'Jane Eyre', @dpl.books[0].title
    assert_equal '10/16/1847', @dpl.books[0].publication_date

    assert_instance_of Book, @dpl.books[1]
    assert_equal 'Harper', @dpl.books[1].author_first_name
    assert_equal 'Lee', @dpl.books[1].author_last_name
    assert_equal 'To Kill a Mockingbird', @dpl.books[1].title
    assert_equal '07/11/1960', @dpl.books[1].publication_date

    assert_instance_of Book, @dpl.books[2]
    assert_equal 'Charlotte', @dpl.books[2].author_first_name
    assert_equal 'Bronte', @dpl.books[2].author_last_name
    assert_equal 'Villette', @dpl.books[2].title
    assert_equal '1853', @dpl.books[2].publication_date

    assert_equal 3, @dpl.books.length
  end

  def test_collection_does_include_a_book
    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(@mockingbird)
    @dpl.add_to_collection(@villette)

    assert @dpl.include?('To Kill a Mockingbird')
  end

  def test_collection_does_not_include_a_book
    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(@mockingbird)
    @dpl.add_to_collection(@villette)

    refute @dpl.include?('A Connecticut Yankee in King Arthur\'s Court')
  end

  def test_returning_author_last_name_sorted_catalogue
    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(@mockingbird)
    @dpl.add_to_collection(@villette)
    catalogue = @dpl.card_catalogue

    assert_instance_of Book, catalogue[0]
    assert_instance_of Book, catalogue[1]
    assert_instance_of Book, catalogue[2]

    assert_equal 'Bronte', catalogue[0].author_last_name
    assert_equal 'Bronte', catalogue[1].author_last_name
    assert_equal 'Lee', catalogue[2].author_last_name
  end

  def test_finding_by_author
    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(@mockingbird)
    @dpl.add_to_collection(@villette)
    
    result = @dpl.find_by_author("Charlotte Bronte")

    assert_instance_of Hash, result
    assert_equal ['Jane Eyre', 'Villette'], result.keys
    assert_equal 2, result.length
    assert_instance_of Book, result['Jane Eyre']
    assert_instance_of Book, result['Villette']
    assert_equal %w[Bronte Bronte], result.values.map(&:author_last_name)
  end

  def test_finding_by_publication_date
    mockingbird = @harper_lee.add_book('To Kill a Mockingbird', '1960')
    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(mockingbird)
    @dpl.add_to_collection(@villette)

    result = @dpl.find_by_publication_date("1960")

    assert_instance_of Hash, result
    assert_equal ['To Kill a Mockingbird'], result.keys
    assert_equal 1, result.length
    assert_instance_of Book, result['To Kill a Mockingbird']
    assert_equal %w[Lee], result.values.map(&:author_last_name)
  end
end
