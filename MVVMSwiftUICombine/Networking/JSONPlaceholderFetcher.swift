import Foundation
import Combine

protocol JSONPlaceholderFetchable {
    func fetchUsers() -> AnyPublisher<[UserResponse], JSONPlaceholderError>
    func fetchUsers() async throws -> [User]
    func fetchPosts() -> AnyPublisher<[PostResponse], JSONPlaceholderError>
    func fetchPosts() async throws -> [Post]
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
        
        return URLSession.shared.dataTaskPublisher(for: url) //koko - use session from init
            .map(\.data) // key-path-expression.
            .decode(type: [UserResponse].self, decoder: JSONDecoder())
            .mapError({ error in
                    .networkFailure
            })
            .eraseToAnyPublisher()
    }
    
    func fetchUsers() async throws -> [User] {
        
        let components = makeUsersComponents()
        guard let url = components.url else {
            throw JSONPlaceholderError.networkFailure
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let usersResponse = try JSONDecoder().decode([UserResponse].self, from: data)
        
        var users = [User]()
        usersResponse.forEach {
            if let user = try? User(from: $0) {
                users.append(user)
            }
        }

        return users
    }
    
    func fetchPosts() -> AnyPublisher<[PostResponse], JSONPlaceholderError>  {
        let components = makePostsComponents()
        guard let url = components.url else {
            let error = JSONPlaceholderError.networkFailure
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url) //koko - use session from init
            .map(\.data) // key-path-expression.
            .decode(type: [PostResponse].self, decoder: JSONDecoder())
            .mapError({ error in
                    .networkFailure
            })
            .eraseToAnyPublisher()
    }
    
    func fetchPosts() async throws -> [Post] {
        
        let components = makePostsComponents()
        guard let url = components.url else {
            throw JSONPlaceholderError.networkFailure
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let postsResponse = try JSONDecoder().decode([PostResponse].self, from: data)
        
        var posts = [Post]()
        postsResponse.forEach {
            if let post = try? Post(from: $0) {
                posts.append(post)
            }
        }

        return posts
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
    
    func makeUsersComponents() -> URLComponents {
        var components = makeCommonComponents()
        components.path = JSONPlaceholderAPI.Path.users
        
        return components
    }
    
    func makePostsComponents() -> URLComponents {
        var components = makeCommonComponents()
        components.path = JSONPlaceholderAPI.Path.posts
        
        return components
    }
    
    private func makeCommonComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = JSONPlaceholderAPI.scheme
        components.host = JSONPlaceholderAPI.host
        
        return components
    }
}
