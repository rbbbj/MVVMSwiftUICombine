import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        Text("User: \(user.name)")
    }
}

#Preview {
    UserRow(user: User.example)
}
