import SwiftUI

final class PostsViewModel: ObservableObject {

    @Published private(set) var posts: [Post] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
    }
    
    @MainActor
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        do {
            posts = try await jSONPlaceholderFetcher.fetchPosts()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
