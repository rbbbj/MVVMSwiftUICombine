import Foundation
import SwiftUI


class UsersCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: UsersSheet?
    @Published var fullScreenCover: UsersFullScreenCover?
    
    
    func push(page: UsersPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: UsersSheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: UsersFullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: UsersPages) -> some View {
        switch page {
        case .main:
            UsersView()
        case .details(let user):
            UserDetailsView(user: user)
        }
    }
    
    // not used - just an example
    @ViewBuilder
    func buildSheet(sheet: UsersSheet) -> some View {
        switch sheet {
        case .firstSheet:
            UserDetailsDummyView()
        case .secondSheet:
            UserDetailsDummyView()
        }
    }
    
    // not used - just an example
    @ViewBuilder
    func buildCover(cover: UsersFullScreenCover) -> some View {
        switch cover {
        case .firstFullScreenCover:
            UserDetailsDummyView()
        case .secondFullScreenCover:
            UserDetailsDummyView()
        }
    }
}

// not used - just an example
struct UserDetailsDummyView: View {
   
    var body: some View {
        Text("Hello")
    }
}
