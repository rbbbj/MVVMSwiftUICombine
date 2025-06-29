import SwiftUI

struct UsersView {
    
    @EnvironmentObject private var coordinator: UsersCoordinator
    @StateObject var viewModel = UsersViewModel(jSONPlaceholderFetcher: JSONPlaceholderFetcher())
    @State private var selectedUser: User?
    
    // add init() here, if present
}
  
extension UsersView: View {
    
    var body: some View {
        NavigationStack {
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
                            coordinator.push(page: .details(user: user))
                        } label: {
                            UserRow(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await viewModel.fetchUsers()
            }
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

// MARK: - #Preview

#if DEBUG

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = UsersCoordinator()
        
        let viewModel = UsersViewModel(jSONPlaceholderFetcher: JSONPlaceholderFetcher())
        viewModel.users = [User.mockUser, User.mockUser]
        
        return UsersView(viewModel: viewModel)
            .environmentObject(coordinator)
    }
}

#endif
