import RealmSwift
import Realm

final class RMUser: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var name: String?
    @Persisted var username: String?
    @Persisted var email: String?
    @Persisted var phone: String?
    @Persisted var website: String?
    @Persisted var address: RMAddress?
    @Persisted var company: RMCompany?
    
    convenience init(from user: User) {
        self.init()
        
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.phone = user.phone
        self.website = user.website
        self.address = user.address.asRealm()
        self.company = user.company.asRealm()
    }
}

extension RMUser {
    func asDomain() throws -> User { return try User(from: self) }
}
