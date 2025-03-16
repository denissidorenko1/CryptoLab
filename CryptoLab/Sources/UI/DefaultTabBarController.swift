import UIKit

// MARK: - DefaultTabBarController
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
