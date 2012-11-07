class BooksController < UITableViewController
  def viewDidLoad
    super

    self.title = "Recommendations"

    @reload_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, target: self, action: :reload)
    self.navigationItem.rightBarButtonItem = @reload_button

    tableView.addPullToRefreshWithActionHandler(
      Proc.new do
        reload
      end
    )

    @books = []
    self.reload
  end

  def reload
    @reload_button.enabled = false

    MBProgressHUD.showHUDAddedTo(self.view, animated:true)

    Dispatch::Queue.main.after(0.5) do
      Book.all do |books|
        @books = books
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        @reload_button.enabled = true
        view.reloadData
        tableView.pullToRefreshView.stopAnimating
      end
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= self.class.name

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
  end

end