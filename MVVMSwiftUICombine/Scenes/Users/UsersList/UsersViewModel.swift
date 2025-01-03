import SwiftUI
import Combine
import SwiftfulLoadingIndicators

enum LoadUsersState {
    case idle
    case loading
    case failed
    case loaded([User])
}

protocol UsersViewModelProtocol {
    func navigateUserDetails()
    func fetchUsers() async
}

final class UsersViewModel: UsersViewModelProtocol, ObservableObject {
    
    @Published var loadState = LoadUsersState.idle
    
    private let router: UsersRouter
    
    private var disposables = Set<AnyCancellable>()
    private let jSONPlaceholderFetcher: JSONPlaceholderFetchable
    
    init(jSONPlaceholderFetcher: JSONPlaceholderFetchable, router: UsersRouter) {
        self.jSONPlaceholderFetcher = jSONPlaceholderFetcher
        self.router = router
        fetchUsers()
    }
    
    func navigateUserDetails() {
        self.router.routeToUserDetails()
    }
    
    func fetchUsers() {
        
        loadState = .loading
        
        jSONPlaceholderFetcher.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        self.loadState = .failed
                    }
                }, receiveValue: { [weak self] usersResponse in
                    guard let self = self else { return }
                    
                    var users = [User]()
                    usersResponse.forEach {
                        if let user = try? User(from: $0) {
                            users.append(user)
                        }
                    }
                    
                    RealmManager.shared.add(users: users)
                    
                    loadState = .loaded(users)
                })
            .store(in: &disposables)
    }
}
