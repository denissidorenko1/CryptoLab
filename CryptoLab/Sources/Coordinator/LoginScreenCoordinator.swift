
import UIKit

final class LoginScreenCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let viewFactory: ViewFactory
    
    init(window: UIWindow, viewFactory: ViewFactory = ViewFactory()) {
        self.window = window
        self.viewFactory = viewFactory
    }
    
    func start() {
        showLoginScreen()
    }
    
    func showLoginScreen() {
        let loginScreenView = viewFactory.makeLoginScreenView(with: self)
        window.rootViewController = loginScreenView
        window.makeKeyAndVisible()
    }
    
    func goToMainScreen() {
        guard let parentCoordinator = parentCoordinator as? AppCoordinator else { return }
        parentCoordinator.pushTabBar()
    }
    

}
