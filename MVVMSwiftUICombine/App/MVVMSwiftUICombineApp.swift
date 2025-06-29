import SwiftUI
import RealmSwift

@main
struct MVVMSwiftUICombineApp: App {
    
    init() {
        #if DEBUG
        print("Realm location: ", Realm.Configuration.defaultConfiguration.fileURL!)
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
