import SwiftUI

struct UsersView: View {
    
    @ObservedObject var viewModel: UsersViewModel
    @State private var selectedUser: User?
    
    var body: some View {
        Group {
            switch viewModel.loadState {
            case .idle:
                Color.clear.onAppear {
                    Task {
                        viewModel.fetchUsers()
                    }
                }
            case .loading:
                VStack {
                    Text("Downloading…")
                    ProgressView()
                }
            case .failed:
                VStack {
                    Text("Failed to download users")
                }
            case .loaded(let users):
                List(users) { user in
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

struct UserRow: View {
    let user: User
    
    var body: some View {
        Text("User: \(user.name)")
            .foregroundColor(.black)
    }
}
