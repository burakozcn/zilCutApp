import UIKit
import Combine

class StartTableViewDataSource<T>: NSObject, UITableViewDataSource, UITableViewDelegate  {
  let build: (UITableView, IndexPath, T) -> UITableViewCell
  var elements: [T] = []
  
  init(builder: @escaping (UITableView, IndexPath, T) -> UITableViewCell) {
    build = builder
    super.init()
  }
  
  func pushElements(_ elements: [T], to tableView: UITableView) {
    tableView.dataSource = self
    self.elements = elements
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    elements.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    build(tableView, indexPath, elements[indexPath.row])
  }
}
