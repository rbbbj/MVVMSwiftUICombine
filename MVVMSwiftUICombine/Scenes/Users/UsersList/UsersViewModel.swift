import SwiftUI
import SwiftfulLoadingIndicators

protocol UsersViewModelProtocol {
    func navigateUserDetails()
}

final class UsersViewModel: UsersViewModelProtocol, ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let router: UsersRouter
    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable, router: UsersRouter) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
        self.router = router
        Task {
            await fetchUsers()
        }
    }
    
    func navigateUserDetails() {
        self.router.routeToUserDetails()
    }
    
    @MainActor
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await jSONPlaceholderFetcher.fetchUsers()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
