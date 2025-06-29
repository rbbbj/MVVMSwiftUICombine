import Foundation

enum UsersPages: Hashable {
    case main
    case details(user: User)
}

// not used - just an example
enum UsersSheet: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case firstSheet
    case secondSheet
}

// not used - just an example
enum UsersFullScreenCover: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case firstFullScreenCover
    case secondFullScreenCover
}

