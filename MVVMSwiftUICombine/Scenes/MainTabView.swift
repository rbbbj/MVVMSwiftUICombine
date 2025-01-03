import SwiftUI

struct MainTabView: View {
    
    @StateObject var firstAppRouter: AppRouter
    @StateObject var secondAppRouter: AppRouter
    
    var body: some View {
        
        TabView {
            NavigationStack(path: $firstAppRouter.paths) {
                firstAppRouter.resolveFirstTabInitialRouter().makeView()
                    .navigationDestination(for: AnyRoutable.self) { router in
                        router.makeView()
                    }
            }
            .tabItem {
                Label("Users", systemImage: "person")
            }
            NavigationStack(path: $secondAppRouter.paths) {
                secondAppRouter.resolveSecondTabInitialRouter().makeView()
                    .navigationDestination(for: AnyRoutable.self) { router in
                        router.makeView()
                    }
            }
            .tabItem {
                Label("Posts", systemImage: "square.and.pencil")
            }
        }
        
    }
}

#Preview {
    MainTabView(firstAppRouter: .init(), secondAppRouter: .init())
}
