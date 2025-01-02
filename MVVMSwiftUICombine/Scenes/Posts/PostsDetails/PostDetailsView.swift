import SwiftUI

struct PostDetailsView: View {
    
    @StateObject private var viewModel = PostDetailsViewModel()
    
    var body: some View {
        Text("User details")
    }
}

//#Preview {
//    UserDetailsView(user: User.example)
//}
