import RealmSwift
import Realm

final class RMPost: Object, ObjectKeyIdentifiable {
    @Persisted var userId: Int?
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var title: String?
    @Persisted var body: String?
    
    convenience init(from post: Post) {
        self.init()
        
        self.userId = post.userId
        self.id = post.id
        self.title = post.title
        self.body = post.body
    }
}

extension RMPost {
    func asDomain() throws -> Post { return try Post(from: self) }
}
