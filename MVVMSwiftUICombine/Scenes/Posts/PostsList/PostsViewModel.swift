import SwiftUI
import Combine
import SwiftfulLoadingIndicators

enum LoadPostsState {
    case idle
    case loading
    case failed
    case loaded([Post])
}

protocol PostsViewModelProtocol {
    func navigateToPostDetails()
    func fetchPosts() async
}

final class PostsViewModel: PostsViewModelProtocol, ObservableObject {
    
    @Published var loadState = LoadPostsState.idle
    
    private let router: PostsRouter
    
    private var disposables = Set<AnyCancellable>()
    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable, router: PostsRouter) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
        self.router = router
        fetchPosts()
    }
    
    func navigateToPostDetails() {
        self.router.routeToPostDetails()
    }
    
    func fetchPosts() {
        
        loadState = .loading
        
        jSONPlaceholderFetcher.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        self.loadState = .failed
                    }
                }, receiveValue: { [weak self] postsResponse in
                    guard let self = self else { return }
                    
                    var posts = [Post]()
                    postsResponse.forEach {
                        if let post = try? Post(from: $0) {
                            posts.append(post)
                        }
                    }
                    
                    RealmManager.shared.add(posts: posts)
                    
                    loadState = .loaded(posts)
                })
            .store(in: &disposables)
    }
}
