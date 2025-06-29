import SwiftUI

struct PostsView {
    
    @EnvironmentObject private var coordinator: PostsCoordinator
    @StateObject var viewModel = PostsViewModel(jSONPlaceholderFetcher: JSONPlaceholderFetcher())
    @State private var selectedPost: Post?
    
    // add init() here, if present
}

extension PostsView: View {
    
    private var isLoadingView: some View {
        ProgressView("Loading posts...")
            .scaleEffect(1.5)
            .padding()
    }
    
    private func errorView(errorMessage: String) -> some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                Task {
                    await viewModel.fetchPosts()
                }
            }) {
                Text("Retry")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    private var listView: some View {
        List(viewModel.posts ) { post in
            Button {
                coordinator.push(page: .details(post: post))
            } label: {
                PostRow(post: post)
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchPosts()
            }
        }
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                isLoadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(errorMessage: errorMessage)
            } else {
                listView
            }
        }
        .navigationTitle("Posts")
        .task {
            await viewModel.fetchPosts()
        }
    }
}

struct PostRow {
    let post: Post
}

extension PostRow: View {
    
    var body: some View {
        Text(post.title)
            .lineLimit(nil)
            .foregroundColor(.black)
    }
}

// MARK: - #Preview

#if DEBUG

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = UsersCoordinator()
        
        let viewModel = PostsViewModel(jSONPlaceholderFetcher: JSONPlaceholderFetcher())
        viewModel.posts = [Post.mockPost, Post.mockPost]
        
        return PostsView(viewModel: viewModel)
            .environmentObject(coordinator)
    }
}

#endif
