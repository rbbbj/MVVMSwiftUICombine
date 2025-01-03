import SwiftUI

struct PostDetailsView: View {
    
    @StateObject private var viewModel = PostDetailsViewModel()
    var post: Post
    
    var body: some View {
        Text("\(post.body)")
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .padding()
    }
}

#Preview {
    PostDetailsView(post: Post.mockPost)
}
