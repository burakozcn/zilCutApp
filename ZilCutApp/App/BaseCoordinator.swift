import Combine
import CoreData

class BaseCoordinator<ResultType> {
  
  private var disposeBag = Set<AnyCancellable>()
  
  private let identifier = UUID()
  private var childCoordinators = [UUID: Any]()
  
  private func store<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = coordinator
  }
  
  private func free<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = coordinator
  }
  
  @discardableResult
  func coordinate<T>(coordinator: BaseCoordinator<T>) -> AnyPublisher<T, Never> {
    store(coordinator: coordinator)
    return coordinator.start()
      .prefix(1)
      .handleEvents(receiveOutput: { [weak self] _ in
        self?.free(coordinator: coordinator)
      }).eraseToAnyPublisher()
  }
  
  func start() -> AnyPublisher<ResultType, Never> {
    fatalError("Start method should be implemented.")
  }
}
