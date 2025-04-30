import SwiftUI

struct PostsView {
    
    @ObservedObject var viewModel: PostsViewModel
    @State private var selectedPost: Post?
    
    // add init() here, if present
}

extension PostsView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading posts...")
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
                } else {
                    List(viewModel.posts ) { post in
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
