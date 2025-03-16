import Foundation

// MARK: - HomeScreenViewModelDelegate
protocol HomeScreenViewModelDelegate: AnyObject {
    func didUpdateTokens()
    func didFailWithError(_ error: Error)
    func didUpdateLoadingState(_ isLoading: Bool)
    func didUpdateSortOrder(_ order: SortingOrder)
}
