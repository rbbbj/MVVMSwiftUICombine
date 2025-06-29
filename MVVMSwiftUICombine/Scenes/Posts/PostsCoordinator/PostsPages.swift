import Foundation

enum PostsPages: Hashable {
    case main
    case details(post: Post)
}

// not used - just an example
enum PostsSheet: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case firstSheet
    case secondSheet
}

// not used - just an example
enum PostsFullScreenCover: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case firstFullScreenCover
    case secondFullScreenCover
}

