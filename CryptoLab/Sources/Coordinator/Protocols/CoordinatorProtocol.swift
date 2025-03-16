import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

// MARK: - NavigationCoordinator
protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

