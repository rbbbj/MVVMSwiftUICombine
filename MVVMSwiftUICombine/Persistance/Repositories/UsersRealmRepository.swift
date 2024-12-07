//import Foundation
//import Realm
//import RealmSwift
//
//class UsersRealmRepository: UsersRealmPersistable {
//    func retrieveUsers() -> Results<RMUser>? {
//        guard let realm = try? Realm() else {
//            return nil
//        }
//
//        let rmUsers = realm.objects(RMUser.self)
//        if rmUsers.isEmpty {
//            return nil
//        }
//
//        return rmUsers
//    }
//    
//    func add(users: [RMUser]) {
//        guard let realm = try? Realm() else {
//            return
//        }
//        
//        try? realm.write {
//            realm.add(users, update: .all)
//        }
//    }
//}
