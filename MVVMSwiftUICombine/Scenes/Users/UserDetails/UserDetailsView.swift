import SwiftUI

struct UserDetailsView: View {
    
    @StateObject private var viewModel = UserDetailsViewModel()
    
    var body: some View {
        Text("User details")
    }
}

//#Preview {
//    UserDetailsView(user: User.example)
//}
