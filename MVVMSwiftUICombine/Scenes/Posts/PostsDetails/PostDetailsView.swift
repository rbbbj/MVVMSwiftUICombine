import SwiftUI

struct PostDetailsView {
    
    @StateObject private var viewModel = PostDetailsViewModel()
    var post: Post
    
    // add init() here, if present
}

extension PostDetailsView: View {
    
    var body: some View {
        Text("\(post.body)")
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .padding()
    }
}
