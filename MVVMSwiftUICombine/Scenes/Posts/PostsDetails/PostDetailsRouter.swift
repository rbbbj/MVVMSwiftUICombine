import SwiftUI

class PostDetailsRouter {
    
    private let rootCoordinator: NavigationCoordinator

    var post: Post
    
    init(rootCoordinator: NavigationCoordinator, post: Post) {
        self.rootCoordinator = rootCoordinator
        self.post = post
    }

    // add routing if neede
    // func routeToSomePage() {}
    
}

// MARK: - ViewFactory implementation

extension PostDetailsRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = PostDetailsViewModel()
        let view = PostDetailsView(post: post)
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
