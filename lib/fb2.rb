require 'nokogiri'
require 'models/fb2_book'
require 'models/fb2_section'

class Fb2
  def self.parse data
    xml = Nokogiri::XML(data)
    
    # building book
    description = xml.css('description')
    book = Fb2Book.new
    book.title = description.css('title-info > book-title').text
    book.author_first_name = description.css('title-info > author > first-name').text
    book.author_last_name = description.css('title-info > author > last-name').text
    book.annotation = description.css('title-info > annotation > p').text
    book.genre = description.css('title-info > genre').text
    book.lang = description.css('title-info > lang').text
    book.keywords = description.css('title-info > keywords').text.split(', ')
    book.sections = []
    
    # building sections
    xml.css('body > section').each do |s|
      section = Fb2Section.new
      section.title = s.css('title > p').text
      section.contents = s.css('p').map{ |e| e.text }.drop(1)
      book.sections << section
    end
    
    book
  end
end
