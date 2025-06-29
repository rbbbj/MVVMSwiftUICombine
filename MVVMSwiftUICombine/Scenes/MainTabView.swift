import SwiftUI

struct MainTabView: View {
    @StateObject private var usersCoordinator = UsersCoordinator()
    @StateObject private var postsCoordinator = PostsCoordinator()

    var body: some View {
        TabView {
            UsersCoordinatorView(coordinator: usersCoordinator)
                .tabItem {
                    Label("Users", systemImage: "person")
                }

            PostsCoordinatorView(coordinator: postsCoordinator)
                .tabItem {
                    Label("Posts", systemImage: "square.and.pencil")
                }
        }
    }
}
