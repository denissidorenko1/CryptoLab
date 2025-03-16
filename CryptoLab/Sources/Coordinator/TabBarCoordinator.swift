import UIKit

final class TabBarCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var tabBarController: UITabBarController

    private let viewFactory: ViewFactory
    
    init(tabBarController: UITabBarController, viewFactory: ViewFactory) {
        self.tabBarController = tabBarController
        self.viewFactory = viewFactory
    }
    
    func start() {
        let homeTabCoordinator = HomeTabCoordinator(
            navigationController: DefaultNavigationController(),
            viewFactory: viewFactory
        )
        
        let graphTabCoordinator = GraphTabCoordinator(
            navigationController: DefaultNavigationController(),
            viewFactory: viewFactory
        )
        
        let walletTabCoordinator = WalletTabCoordinator(
            navigationController: DefaultNavigationController(),
            viewFactory: viewFactory
        )
        
        let documentTabCoordinator = DocumentTabCoordinator(
            navigationController: DefaultNavigationController(),
            viewFactory: viewFactory
        )
        
        let profileTabCoordinator = ProfileTabCoordinator(
            navigationController: DefaultNavigationController(),
            viewFactory: viewFactory
        )
        
        let coordinators: [NavigationCoordinator] = [
            homeTabCoordinator,
            graphTabCoordinator,
            walletTabCoordinator,
            documentTabCoordinator,
            profileTabCoordinator
        ]
        
        coordinators.forEach { coordinator in
            childCoordinators.append(coordinator)
            coordinator.parentCoordinator = self
            coordinator.start()
        }

        tabBarController.viewControllers = coordinators.map { $0.navigationController }
    }

    func switchToTab(index: Int) {
        tabBarController.selectedIndex = index
    }
    
    // FIXME: нейминг
    func popBack() {
        guard let appCoordinator = parentCoordinator as? AppCoordinator else { return }
        appCoordinator.pushLoginScreen()
    }
}

final class DefaultNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
//        interactivePopGestureRecognizer?.delegate = self
    }
}

//extension DefaultNavigationController: UIGestureRecognizerDelegate {
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//
//}

