import RealmSwift
import Realm

final class RMLocation: Object {
    @Persisted var lat: String?
    @Persisted var lng: String?
    
    convenience init(from location: Location) {
        self.init()
        
        self.lat = location.lat
        self.lng = location.lng
    }
}

extension RMLocation {
    func asDomain() throws -> Location { return try Location(from: self) }
}
