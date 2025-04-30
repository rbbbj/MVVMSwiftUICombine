import SwiftUI
import SwiftfulLoadingIndicators

protocol PostsViewModelProtocol {
    func navigateToPostDetails()
}

final class PostsViewModel: PostsViewModelProtocol, ObservableObject {

    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let router: PostsRouter
    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable, router: PostsRouter) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
        self.router = router
        Task {
            await fetchPosts()
        }
    }
    
    func navigateToPostDetails() {
        self.router.routeToPostDetails()
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
