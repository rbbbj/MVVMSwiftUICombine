import SwiftUI

struct PostsView: View {

    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        Text("Posts")
    }
}

//#Preview {
//    UserDetailsView(user: User.example)
//}
