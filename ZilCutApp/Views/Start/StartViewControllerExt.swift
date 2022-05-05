import UIKit

extension StartViewController: UITableViewDelegate {
  func items<T>(_ builder: @escaping (UITableView, IndexPath, T) -> UITableViewCell) -> ([T]) -> Void {
    let dataSource = StartProductTableViewDataSource(builder: builder)
    return { items in
      dataSource.pushElements(items, to: self.productTableView)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    productNameTextField.text = viewModel.resultArray[indexPath.row]
    productTableView.isHidden = true
  }
}
