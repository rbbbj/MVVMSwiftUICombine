import SwiftUI

struct PostsView: View {
    
    @ObservedObject var viewModel: PostsViewModel
    @State private var selectedPost: Post?
    
    var body: some View {
        Group {
            switch viewModel.loadState {
            case .idle:
                Color.clear.onAppear {
                    Task {
                        viewModel.fetchPosts()
                    }
                }
            case .loading:
                VStack {
                    Text("Downloading…")
                    ProgressView()
                }
            case .failed:
                VStack {
                    Text("Failed to download posts")
                }
            case .loaded(let posts):
                List(posts) { post in
                    Button {
                        selectedPost = post
                        viewModel.navigateToPostDetails()
                    } label: {
                        PostRow(post: post)
                    }
                }
            }
        }
        .navigationTitle("Posts")
    }
}

struct PostRow: View {
    let post: Post
    
    var body: some View {
        Text("Post: \(post.title)")
            .lineLimit(nil)
            .foregroundColor(.black)
    }
}
