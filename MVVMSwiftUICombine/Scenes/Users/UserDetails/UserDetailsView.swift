import SwiftUI

struct UserDetailsView: View {
    
    @StateObject private var viewModel = UserDetailsViewModel()
    var user: User
    
    var body: some View {
        Text("\(user.name)")
        Text("\(user.phone)")
    }
}

//#Preview {
//    UserDetailsView(user: User.mockUser)
//}

#if DEBUG
// MARK: - #Preview

private struct PreviewView: View {

    var body: some View {
        UserDetailsView(user: User.mockUser)
    }
}

#Preview { PreviewView() }
#endif
