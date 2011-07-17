require 'helper'

class TestFb2 < Test::Unit::TestCase
  context "parsing" do
    setup do
      @book = Fb2::parse(open('test/fixtures/sample.fb2'))
    end
    
    should "parse books" do
      assert_instance_of(Book, @book)
    end
    
    should "load correct title" do
      assert_equal('Fiction Book', @book.title)
    end
    
    should "load correct author" do
      assert_equal('John Doe', [@book.author_first_name, @book.author_last_name].join(' '))
    end
    
    should "load correct annotation" do
      assert_equal('Hello', @book.annotation)
    end
    
    should "load correct genre" do
      assert_equal('fiction', @book.genre)
    end
    
    should "load correct language" do
      assert_equal('en', @book.lang)
    end
    
    should "load correct keywords" do
      assert_equal(['john', 'doe', 'fiction'], @book.keywords)
    end
    
    should "load all two chapters" do
      assert_equal(2, @book.sections.length)
    end
    
    should "load correct second chapter's title" do
      assert_equal('Chapter 2', @book.sections[1].title)
    end
    
    should "load all strings in each section" do
      assert_equal(3, @book.sections[0].contents.length)
      assert_equal(4, @book.sections[1].contents.length)
    end
  end
end
