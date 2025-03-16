import Foundation

// MARK: - HomeScreenViewModelProtocol
protocol HomeScreenViewModelProtocol {
    var tokens: [Token] { get }
    var delegate: HomeScreenViewModelDelegate? { get set }
    
    func fetchTokens()
    func logout()
    func toggleSorting()
}

// MARK: - HomeScreenViewModel
final class HomeScreenViewModel: HomeScreenViewModelProtocol {
    // MARK: - Dependencies
    private let networkingService: NetworkingService
    
    // MARK: - Public Properties
    weak var delegate: HomeScreenViewModelDelegate?
    
    var tokens: [Token] {
        return model.tokens
    }
    
    // MARK: - Private Properties
    private(set) var model: HomeScreenModelProtocol
    
    // MARK: - Static Properties
    static let tokenNames: [String] = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    // MARK: - Initializer
    init(networkingService: NetworkingService = NetworkingService()) {
        self.networkingService = networkingService
        self.model = HomeScreenModel(tokens: [], sortOrder: .descending)
    }
    
    // MARK: - Public Methods
    func fetchTokens() {
        Task {
            await updateLoadingState(true)
            
            do {
                model.tokens = []
                await notifyUpdate()
                model.tokens = try await networkingService.getTokens(tokenNames: Self.tokenNames)
                model.toggleSorting()
                await updateLoadingState(false)
                await notifyUpdate()
            } catch {
                await updateLoadingState(false)
                await notifyError(error)
            }
        }
    }

    func logout() {
        let authRepository = UserDefaultsAuthRepository()
        let authService = DefaultAuthService(authRepository: authRepository)
        authService.logout()
    }
    
    @MainActor func toggleSorting() {
        model.toggleSorting()
        delegate?.didUpdateSortOrder(model.sortOrder)
        notifyUpdate()
    }
    
    // MARK: - Private Methods
    @MainActor private func updateLoadingState(_ isLoading: Bool) {
        delegate?.didUpdateLoadingState(isLoading)
    }
    
    @MainActor private func notifyUpdate() {
        delegate?.didUpdateTokens()
    }
    
    @MainActor private func notifyError(_ error: Error) {
        delegate?.didFailWithError(error)
    }
}
