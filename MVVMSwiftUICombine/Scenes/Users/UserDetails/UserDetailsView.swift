import SwiftUI

struct UserDetailsView: View {
    
    @StateObject private var viewModel = UserDetailsViewModel()
    var user: User
    
    var body: some View {
        Text("\(user.name)")
        Text("\(user.phone)")
    }
}
