import SwiftUI

class UsersRouter {
    
    private let rootCoordinator: NavigationCoordinator
    
    var user: User
    
    
    init(rootCoordinator: NavigationCoordinator, user: User) {
        self.rootCoordinator = rootCoordinator
        self.user = user
    }
    
    func routeToUserDetails() {
        let router = UserDetailsRouter(rootCoordinator: self.rootCoordinator, user: self.user)
        rootCoordinator.push(router)
    }
}

// MARK: - ViewFactory implementation

extension UsersRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = UsersViewModel(jSONPlaceholderFetcher: JSONPlaceholderFetcher(), router: self)
        let view = UsersView(viewModel: viewModel)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation

extension UsersRouter {
    static func == (lhs: UsersRouter, rhs: UsersRouter) -> Bool {
        lhs.user.id == rhs.user.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.user.id)
    }
}
