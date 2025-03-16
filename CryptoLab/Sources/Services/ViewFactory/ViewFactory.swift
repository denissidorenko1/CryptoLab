import Foundation
final class ViewFactory: ViewFactoryProtocol {
    func makeLoginScreenView(with coordinator: Coordinator) -> LoginScreenView {
        let authRepository = UserDefaultsAuthRepository()
        let authService = DefaultAuthService(authRepository: authRepository)
        let viewModel = LoginScreenViewModel(authService: authService)
        return LoginScreenView(viewModel: viewModel, coordinator: coordinator)
    }
    
    func makeDetailedScreenView(with coordinator: Coordinator, with model: Token) -> DetailedInfoScreenView {
        let viewModel = DetailedInfoScreenViewModel(model: model)
        return DetailedInfoScreenView(viewModel: viewModel, coordinator: coordinator)
    }
    
    func makeHomeScreenView(with coordinator: Coordinator) -> HomeScreenView {
        HomeScreenView(viewModel: HomeScreenViewModel(), coordinator: coordinator)
    }
    
    func makeGraphScreenView(with coordinator: Coordinator) -> GraphScreenView {
        GraphScreenView(coordinator: coordinator)
    }
    
    func makeWalletScreenView(with coordinator: Coordinator) -> WalletScreenView {
        WalletScreenView(coordinator: coordinator)
    }
    
    func makeDocumentScreenView(with coordinator: Coordinator) -> DocumentScreenView {
        DocumentScreenView(coordinator: coordinator)
    }
    
    func makeProfileScreenView(with coordinator: Coordinator) -> ProfileScreenView {
        ProfileScreenView(coordinator: coordinator)
    }
}
