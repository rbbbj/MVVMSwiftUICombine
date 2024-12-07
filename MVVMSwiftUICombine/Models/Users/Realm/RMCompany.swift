import RealmSwift
import Realm

final class RMCompany: Object {
    @Persisted var name: String?
    @Persisted var catchPhrase: String?
    @Persisted var bs: String?
    
    convenience init(from company: Company) {
        self.init()
        
        self.name = company.name
        self.catchPhrase = company.catchPhrase
        self.bs = company.bs
    }
}

extension RMCompany {
    func asDomain() throws -> Company { return try Company(from: self) }
}
