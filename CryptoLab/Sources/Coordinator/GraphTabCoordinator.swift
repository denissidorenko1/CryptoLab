import UIKit

final class GraphTabCoordinator: NavigationCoordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let viewFactory: ViewFactory
    
    init(navigationController: UINavigationController, viewFactory: ViewFactory) {
        self.navigationController = navigationController
        self.viewFactory = viewFactory
    }
    
    func start() {
        let view = viewFactory.makeGraphScreenView(with: self)
        navigationController.pushViewController(view, animated: true)
    }
}
