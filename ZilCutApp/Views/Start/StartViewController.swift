import UIKit

class StartViewController: UITableViewController {
  private var viewModel: StartViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = StartViewModel()
    
    self.tableView.register(UINib(nibName: "StartTableViewCell", bundle: .main), forCellReuseIdentifier: "StartTableViewCell")
    viewModel.tableView(startVC: self)
  }
  
  // MARK: - Table view data source
    
  func items<T>(_ builder: @escaping (UITableView, IndexPath, T) -> UITableViewCell) -> ([T]) -> Void {
    let dataSource = StartTableViewDataSource(builder: builder)
    return { items in
      dataSource.pushElements(items, to: self.tableView)
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.goToMaterial(indexPath: indexPath)
  }
}
