import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        Text("User: \(user.name)")
    }
}

#Preview {
    let user = User(id: 9,
                    name: "Glenna Reichert",
                    username: "Delphine",
                    email: "Chaim_McDermott@dana.io",
                    phone: "(775)976-6794 x41206",
                    website: "conrad.com",
                    address: Address(street: "Dayna Park", suite: "Suite 449", city: "Bartholomebury", zipcode: "76495-3109", geo: Location(lat: "24.6463", lng: "-168.8889")),
                    company: Company(name: "Yost and Sons", catchPhrase: "Switchable contextually-based project", bs: "aggregate real-time technologies"))
    
    return UserRow(user: user)
}
