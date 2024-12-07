import SwiftUI

struct Users: View {
    @StateObject var viewModel: UsersViewModel = UsersViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.loadState {
                case .idle:
                    Color.clear.onAppear {
                            Task {
                                await viewModel.getUsers()
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
                    List(users, rowContent: UserRow.init)
                        .refreshable {
                            Task {
                                await viewModel.getUsers()
                            }
                        }
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    Users()
}
