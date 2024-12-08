import SwiftUI

struct Users: View {
    @StateObject var viewModel: UsersViewModel = UsersViewModel(jSONPlaceholderFetcher: JSONPlaceholderFetcher())
    
    var body: some View {
        NavigationStack {
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
                    List(users, rowContent: UserRow.init)
                        .refreshable {
                            Task {
                                viewModel.fetchUsers()
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
