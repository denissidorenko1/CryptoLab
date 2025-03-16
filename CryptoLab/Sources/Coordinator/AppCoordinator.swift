import UIKit

// MARK: - AppCoordinator
final class AppCoordinator: Coordinator {
    // MARK: - Public Properties
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    // MARK: Private Properties
    private let window: UIWindow
    private let viewFactory: ViewFactory
    
    
    // MARK: Initializers
    init(window: UIWindow, viewFactory: ViewFactory = ViewFactory()) {
        self.window = window
        self.viewFactory = viewFactory
    }
    
    // MARK: - Public methods
    func start() {
        let authRepository = UserDefaultsAuthRepository()
        let authService = DefaultAuthService(authRepository: authRepository)
        if authService.isAuthenticated() {
            pushTabBar()
        } else {
            pushLoginScreen()
        }
    }
    
    func pushLoginScreen() {
        let loginScreenCoordinator = LoginScreenCoordinator(window: window, viewFactory: viewFactory)
        loginScreenCoordinator.parentCoordinator = self
        loginScreenCoordinator.start()
        
        childCoordinators = []
        childCoordinators.append(loginScreenCoordinator)
    }
    
    func pushTabBar() {
        let tabBarCoordinator = TabBarCoordinator(
            tabBarController: DefaultTabBarController(),
            viewFactory: viewFactory
        )
        childCoordinators = []
        childCoordinators.append(tabBarCoordinator)
        
        tabBarCoordinator.parentCoordinator = self
        tabBarCoordinator.start()
        window.rootViewController = tabBarCoordinator.tabBarController
        window.makeKeyAndVisible()
    }
}
