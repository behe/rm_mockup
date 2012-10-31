class BooksController < UIViewController
  def viewDidLoad
    super

    self.title = "Recommendations"

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview @table
    @reload_button                         = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, target: self, action: :reload)
    self.navigationItem.rightBarButtonItem = @reload_button

    @table.dataSource = self
    @table.delegate   = self

    @books = []
    self.reload
  end

  def reload
    @reload_button.enabled = false

    MBProgressHUD.showHUDAddedTo(self.view, animated:true)

    #operation = proc do
      # expensive query:
      Book.all do |books|
        @books = books
        MBProgressHUD.hideHUDForView(self.view, animated:true)
        @reload_button.enabled = true
        @table.reloadData
      end
      #BW::HTTP.get("http://readingrecs.adaptiv.se/books.json") do |response|
      #  @books = BW::JSON.parse(response.body.to_str)
      #end
    #end

    #callback = proc do |result|
      # hide the HUD
    #end

    #BW::Reactor.defer(operation, callback)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    end

    cell.textLabel.text = @books[indexPath.row].title

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @books.count
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    self.navigationController.pushViewController(BookController.alloc.initWithBook(@books[indexPath.row]), animated:true)
    #alert         = UIAlertView.alloc.init
    #alert.message = "#{@books[indexPath.row]['title']} tapped!"
    #alert.addButtonWithTitle "OK"
    #alert.show
  end

end