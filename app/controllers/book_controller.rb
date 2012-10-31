class BookController < UIViewController
  attr_accessor :book

  def initWithBook(book)
    initWithNibName(nil, bundle: nil)
    self.book = book
    self
  end

  def viewDidLoad
    super


    self.title = self.book.title
    self.view.backgroundColor = UIColor.whiteColor

    @book_title      = UILabel.alloc.initWithFrame self.view.bounds
    @book_title.numberOfLines = 5
    @book_title.text = self.book.title
    @book_title.sizeToFit
    self.view.addSubview @book_title

    imageData = NSData.dataWithContentsOfURL(NSURL.URLWithString(self.book.image_url))
    @book_image = UIImage.imageWithData imageData

    image_view = UIImageView.alloc.initWithImage(@book_image)
    image_view.frame = CGRectMake(0, @book_title.size.height, @book_image.size.width/2, @book_image.size.height/2)
    self.view.addSubview image_view
  end
end