import Foundation
import Combine

protocol JSONPlaceholderFetchable {
    func fetchUsers() -> AnyPublisher<[UserResponse], JSONPlaceholderError>
}

class JSONPlaceholderFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension JSONPlaceholderFetcher: JSONPlaceholderFetchable {
    
    func fetchUsers() -> AnyPublisher<[UserResponse], JSONPlaceholderError>  {
        let components = makeUsersComponents()
        guard let url = components.url else {
            let error = JSONPlaceholderError.networkFailure
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // key-path-expression.
            .decode(type: [UserResponse].self, decoder: JSONDecoder())
            .mapError({ error in
                    .networkFailure
            })
            .eraseToAnyPublisher()
    }
}

private extension JSONPlaceholderFetcher {
    struct JSONPlaceholderAPI {
        static let scheme = "https"
        static let host = "jsonplaceholder.typicode.com"
        struct Path {
            static let posts = "/posts"
            static let users = "/users"
        }
    }
    
    func makePostsComponents() -> URLComponents {
        var components = makeCommonComponents()
        components.path = JSONPlaceholderAPI.Path.posts
        
        return components
    }
    
    func makeUsersComponents() -> URLComponents {
        var components = makeCommonComponents()
        components.path = JSONPlaceholderAPI.Path.users
        
        return components
    }
    
    private func makeCommonComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = JSONPlaceholderAPI.scheme
        components.host = JSONPlaceholderAPI.host
        
        return components
    }
}
