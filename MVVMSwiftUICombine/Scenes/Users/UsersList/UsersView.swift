import SwiftUI

struct UsersView: View {
    
    @ObservedObject var viewModel: UsersViewModel
    @State private var selectedUser: User?
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                        .scaleEffect(1.5)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }) {
                            Text("Retry")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                } else {
                    List(viewModel.users) { user in
                        Button {
                            selectedUser = user
                            viewModel.navigateUserDetails()
                        } label: {
                            UserRow(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct UserRow: View {
    let user: User
    
    var body: some View {
        Text(user.name)
            .foregroundColor(.black)
    }
}

#if DEBUG
// MARK: - #Preview

private class PreviewNavigationCoordinator: NavigationCoordinator {
    func push(_ router: any Routable) {}
    func popLast() {}
    func popToRoot() {}
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        let mockFetcher = JSONPlaceholderFetcher()
        let mockCoordinator = PreviewNavigationCoordinator()
        let mockRouter = UsersRouter(rootCoordinator: mockCoordinator, user: User.mockUser)
        let mockViewModel = UsersViewModel(jSONPlaceholderFetcher: mockFetcher, router: mockRouter)
        mockViewModel.users = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com", phone: "123-456-7890", website: "johndoe.com", address: User.mockUser.address, company: User.mockUser.company),
            User(id: 2, name: "Jane Smith", username: "janesmith", email: "jane@example.com", phone: "987-654-3210", website: "janesmith.com", address: User.mockUser.address, company: User.mockUser.company)
        ]
        return UsersView(viewModel: mockViewModel)
    }
}
#endif
