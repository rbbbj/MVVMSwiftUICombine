import RealmSwift
import Realm

final class RMAddress: Object {
    @Persisted var street: String?
    @Persisted var suite: String?
    @Persisted var city: String?
    @Persisted var zipcode: String?
    @Persisted var geo: RMLocation?
    
    convenience init(from adress: Address) {
        self.init()
        
        self.street = adress.street
        self.suite = adress.suite
        self.city = adress.city
        self.zipcode = adress.zipcode
        self.geo = adress.geo.asRealm()
    }
}

extension RMAddress {
    func asDomain() throws -> Address { return try Address(from: self) }
}
