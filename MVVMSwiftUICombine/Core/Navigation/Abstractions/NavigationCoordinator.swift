// see:
// medium.com/@maydibee/navigation-in-swiftui-flexible-and-scalable-routing-approach-with-stackview-1a819cd9d6f0
// for flexible and scalable routing approach for swiftui

protocol NavigationCoordinator {
    func push(_ path: any Routable)
    func popLast()
    func popToRoot()
}
