import Foundation

protocol ViewFactoryProtocol {
    func makeLoginScreenView(with coordinator: Coordinator) -> LoginScreenView
    func makeDetailedScreenView(with coordinator: Coordinator, with model: Token) -> DetailedInfoScreenView
    func makeHomeScreenView(with coordinator: Coordinator) -> HomeScreenView
    
    func makeGraphScreenView(with coordinator: Coordinator) -> GraphScreenView
    func makeWalletScreenView(with coordinator: Coordinator) -> WalletScreenView
    func makeDocumentScreenView(with coordinator: Coordinator) -> DocumentScreenView
    func makeProfileScreenView(with coordinator: Coordinator) -> ProfileScreenView
}
