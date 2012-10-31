describe "Application 'Readingrecs'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end
end

describe Book do
  it "can be initialized from hash" do
    book_hash = {
      "title"     => "Adapt: Why Success Always Starts with Failure",
      "author"    => "Tim Harford",
      "image_url" => "http://ecx.images-amazon.com/images/I/41U4L1IyeCL.jpg",
      "buy_url"   => "http://www.amazon.com/Adapt-Success-Always-Starts-Failure/dp/1250007550%3FSubscriptionId%3DAKIAJQDZ4SYUYSLDGWJA%26tag%3Dadaptiv_20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D1250007550",
      "adaptiv_review" => "This is a short review for Adapt: Why Success Always Starts with Failure.\nWith a line break."
    }
    book = Book.new(book_hash)
    book.title.should == "Adapt: Why Success Always Starts with Failure"
    book.author.should == "Tim Harford"
    book.image_url.should == "http://ecx.images-amazon.com/images/I/41U4L1IyeCL.jpg"
    book.buy_url.should == "http://www.amazon.com/Adapt-Success-Always-Starts-Failure/dp/1250007550%3FSubscriptionId%3DAKIAJQDZ4SYUYSLDGWJA%26tag%3Dadaptiv_20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D1250007550"
    book.adaptiv_review.should == "This is a short review for Adapt: Why Success Always Starts with Failure.\nWith a line break."
  end
end