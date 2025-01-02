import SwiftUI

class AppRouter: ObservableObject {
    @Published var paths: NavigationPath
    
    init(paths: NavigationPath = NavigationPath()) {
        self.paths = paths
    }
    
    
    func resolveFirstTabInitialRouter() -> any Routable {
        let usersRouter = UsersRouter(rootCoordinator: self, user: User.mockUser)
        return usersRouter
    }
    
    func resolveSecondTabInitialRouter() -> any Routable {
        let postsRouter = PostsRouter(rootCoordinator: self, post: Post.mockPost)
        return postsRouter
    }
    
    
    
//    func resolveInitialRouter() -> any Routable {
//        let homePageRouter = HomePageRouter(rootCoordinator: self, user: Datasource.mockUser)
//        return homePageRouter
//    }
    
}

// MARK: NavigationCoordinator implementation

extension AppRouter: NavigationCoordinator {
    func push(_ router: any Routable) {
        DispatchQueue.main.async {
            let wrappedRouter = AnyRoutable(router)
            self.paths.append(wrappedRouter)
        }
    }
    
    func popLast() {
        DispatchQueue.main.async {
            self.paths.removeLast()
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async {
            self.paths.removeLast(self.paths.count)
        }
    }
    
}
