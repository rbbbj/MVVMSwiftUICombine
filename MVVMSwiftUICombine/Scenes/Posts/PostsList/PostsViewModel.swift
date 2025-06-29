import SwiftUI

final class PostsViewModel: ObservableObject {

    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
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
