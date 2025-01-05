import SwiftUI

struct PostsView: View {
    
    @ObservedObject var viewModel: PostsViewModel
    @State private var selectedPost: Post?
    
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

struct PostRow: View {
    let post: Post
    
    var body: some View {
        Text(post.title)
            .lineLimit(nil)
            .foregroundColor(.black)
    }
}
