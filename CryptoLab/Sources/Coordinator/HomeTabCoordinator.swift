import UIKit

final class HomeTabCoordinator: NavigationCoordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let viewFactory: ViewFactory
    
    init(navigationController: UINavigationController, viewFactory: ViewFactory) {
        self.navigationController = navigationController
        self.viewFactory = viewFactory
    }
    
    func start() {
        let view = viewFactory.makeHomeScreenView(with: self)
        navigationController.pushViewController(view, animated: true)
    }
    
    func pushDetailedInfoScreenView(with model: Token) {
        let detailedInfoScreenView = viewFactory.makeDetailedScreenView(with: self, with: model)
        navigationController.pushViewController(detailedInfoScreenView, animated: true)
    }
    
    func popDetailedInfoScreenView() {
        navigationController.popViewController(animated: true)
    }
    
    func popTabBar() {
        guard let tabBarCoordinator = parentCoordinator as? TabBarCoordinator else { return }
        tabBarCoordinator.popBack()
    }
}


