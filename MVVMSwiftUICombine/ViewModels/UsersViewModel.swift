import SwiftUI
import SwiftfulLoadingIndicators

enum LoadState {
    case idle
    case loading
    case failed
    case loaded([User])
}

protocol UsersViewModelProtocol {
    func getUsers() async
}

@MainActor
final class UsersViewModel: UsersViewModelProtocol, ObservableObject {
    
    @Published var users = [User]()
    @Published var loadState = LoadState.idle
    
    func getUsers() async {
        loadState = .loading
        
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let usersResponse = try decoder.decode([UserResponse].self, from: data)//.sorted()
            
            users = [User]()
            usersResponse.forEach {
                if let user = try? User(from: $0) {
                    users.append(user)
                }
            }
            
            loadState = .loaded(users)
        } catch {
            loadState = .failed
        }
    }
}
