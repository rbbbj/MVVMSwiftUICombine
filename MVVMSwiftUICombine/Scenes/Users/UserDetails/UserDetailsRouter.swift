import SwiftUI

class UserDetailsRouter {
    
    private let rootCoordinator: NavigationCoordinator

    var user: User
    
    
    init(rootCoordinator: NavigationCoordinator, user: User) {
        self.rootCoordinator = rootCoordinator
        self.user = user
    }
    
    // add routing if neede
    // func routeToSomePage() {}
    
}

// MARK: - ViewFactory implementation

extension UserDetailsRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = UserDetailsViewModel()
        let view = UserDetailsView(user: user)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation

extension UserDetailsRouter {
    static func == (lhs: UserDetailsRouter, rhs: UserDetailsRouter) -> Bool {
        lhs.user.id == rhs.user.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.user.id)
    }
}
