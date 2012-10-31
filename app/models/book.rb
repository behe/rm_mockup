class Book
  PROPERTIES = [:title, :author, :image_url, :buy_url, :adaptiv_review]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def self.all(&block)
    #if @books
    #  block.call(@books)
    #end

    BW::HTTP.get("http://readingrecs.adaptiv.se/books.json") do |response|
      data = BW::JSON.parse(response.body.to_str)
      @books = data.map { |book_data| Book.new(book_data) }
      block.call(@books)
    end
  end
end
