import Foundation
import RealmSwift


final class RealmManager {
    private(set) var localRealm: Realm?
    static let shared = RealmManager()
    
    private init() {
        openRealm()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    // MARK: - User
    
    func getUsers() -> [User]? {
        guard let realm = localRealm else {
            return nil
        }
        
        let rmUsers = realm.objects(RMUser.self)
        if rmUsers.isEmpty {
            return nil
        }
        
        return rmUsers.compactMap{ try? $0.asDomain() }
    }
    
    func add(users: [User]) {
        guard let realm = localRealm else {
            return
        }
        
        try? realm.write {
            let rmUsers = users.map({ $0.asRealm() })
            realm.add(rmUsers, update: .all)
        }
    }
}
