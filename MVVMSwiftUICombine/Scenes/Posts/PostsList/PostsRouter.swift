import SwiftUI

class PostsRouter {
    
    private let rootCoordinator: NavigationCoordinator
    
    var post: Post
    
    
    init(rootCoordinator: NavigationCoordinator, post: Post) {
        self.rootCoordinator = rootCoordinator
        self.post = post
    }
    
    func routeToPostDetails() {
        let router = PostDetailsRouter(rootCoordinator: self.rootCoordinator, post: self.post)
        rootCoordinator.push(router)
    }
}

// MARK: - ViewFactory implementation

extension PostsRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = PostsViewModel()
        let view = PostsView(viewModel: viewModel)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation

extension PostsRouter {
    static func == (lhs: PostsRouter, rhs: PostsRouter) -> Bool {
        lhs.post.id == rhs.post.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.post.id)
    }
}

//// MARK: - Router mock for preview
//
//extension UsersRouter {
//    static let mock: UsersRouter = .init(rootCoordinator: AppRouter(), user: Datasource.mockUser)
//}
