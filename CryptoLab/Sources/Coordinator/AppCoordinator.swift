import UIKit

final class AppCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let viewFactory: ViewFactory
    
    init(window: UIWindow, viewFactory: ViewFactory = ViewFactory()) {
        self.window = window
        self.viewFactory = viewFactory
    }
    
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

final class DefaultTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .customBlack
        tabBar.unselectedItemTintColor = .customDeselectedIcon
    }
}

