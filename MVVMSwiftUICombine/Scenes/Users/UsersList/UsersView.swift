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
