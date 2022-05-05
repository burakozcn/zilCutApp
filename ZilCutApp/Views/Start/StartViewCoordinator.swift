import UIKit
import Combine

class StartViewCoordinator: BaseCoordinator<Void> {
  private var startViewModel: StartViewModel!
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    startViewModel = StartViewModel()
    startViewModel.startView(window: window)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
}
