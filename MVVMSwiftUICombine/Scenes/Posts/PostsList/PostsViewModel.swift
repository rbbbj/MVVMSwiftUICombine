import SwiftUI
import Combine

final class PostsViewModel: ObservableObject {

    @Published private(set) var posts: [Post] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    private var cancellables = Set<AnyCancellable>()
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
    }
    
    // Combine version of fetchPosts
    // (see UsersViewModel fetchUsers() for non-reactive version of the same)
    func fetchPosts() {
        isLoading = true
        errorMessage = nil
        
        Future<[Post], Error> { [weak self] promise in
            guard let self = self else { return }
            Task {
                do {
                    let posts = try await self.jSONPlaceholderFetcher.fetchPosts()
                    promise(.success(posts))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard let self = self else { return }
            self.isLoading = false
            if case let .failure(error) = completion {
                self.errorMessage = error.localizedDescription
            }
        } receiveValue: { [weak self] posts in
            self?.posts = posts
        }
        .store(in: &cancellables)
    }
}
