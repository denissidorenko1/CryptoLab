import UIKit

final class ProfileTabCoordinator: NavigationCoordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let viewFactory: ViewFactory
    
    init(navigationController: UINavigationController, viewFactory: ViewFactory) {
        self.navigationController = navigationController
        self.viewFactory = viewFactory
    }
    
    func start() {
        let view = viewFactory.makeProfileScreenView(with: self)
        navigationController.pushViewController(view, animated: true)
    }
}
