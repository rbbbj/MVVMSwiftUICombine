import SwiftUI

final class UsersViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
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
            isLoading = false
        }
    }
}
