import SwiftUI

class PostDetailsRouter {
    
    private let rootCoordinator: NavigationCoordinator

    var post: Post
    
    init(rootCoordinator: NavigationCoordinator, post: Post) {
        self.rootCoordinator = rootCoordinator
        self.post = post
    }
    
//    func routeToSomePage() {}
    
}

// MARK: - ViewFactory implementation

extension PostDetailsRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = PostDetailsViewModel()
        let view = PostDetailsView()
        return AnyView(view)
    }
}

// MARK: - Hashable implementation

extension PostDetailsRouter {
    static func == (lhs: PostDetailsRouter, rhs: PostDetailsRouter) -> Bool {
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
