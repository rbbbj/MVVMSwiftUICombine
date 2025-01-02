import SwiftUI

class UserDetailsRouter {
    
    private let rootCoordinator: NavigationCoordinator

    var user: User
    
    
    init(rootCoordinator: NavigationCoordinator, user: User) {
        self.rootCoordinator = rootCoordinator
        self.user = user
    }
    
//    func routeToSomePage() {}
    
}

// MARK: - ViewFactory implementation

extension UserDetailsRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = UserDetailsViewModel()
        let view = UserDetailsView()
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

//// MARK: - Router mock for preview
//
//extension UsersRouter {
//    static let mock: UsersRouter = .init(rootCoordinator: AppRouter(), user: Datasource.mockUser)
//}
