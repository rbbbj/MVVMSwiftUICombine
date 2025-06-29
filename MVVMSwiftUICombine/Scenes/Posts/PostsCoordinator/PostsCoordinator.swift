import Foundation
import SwiftUI


class PostsCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: PostsSheet?
    @Published var fullScreenCover: PostsFullScreenCover?
    
    
    func push(page: PostsPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: PostsSheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: PostsFullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: PostsPages) -> some View {
        switch page {
        case .main:
            PostsView()
        case .details(let post):
            PostDetailsView(post: post)
        }
    }
    
    // not used - just an example
    @ViewBuilder
    func buildSheet(sheet: PostsSheet) -> some View {
        switch sheet {
        case .firstSheet:
            PostDetailsDummyView()
        case .secondSheet:
            PostDetailsDummyView()
        }
    }
    
    // not used - just an example
    @ViewBuilder
    func buildCover(cover: PostsFullScreenCover) -> some View {
        switch cover {
        case .firstFullScreenCover:
            PostDetailsDummyView()
        case .secondFullScreenCover:
            PostDetailsDummyView()
        }
    }
}

// not used - just an example
struct PostDetailsDummyView: View {
   
    var body: some View {
        Text("Hello")
    }
}
