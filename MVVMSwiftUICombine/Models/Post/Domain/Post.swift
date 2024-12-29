struct Post: Identifiable {
    private(set) var userId: Int
    private(set) var id: Int
    private(set) var title: String
    private(set) var body: String
    
    init(userId: Int,
         id: Int,
         title: String,
         body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    init(from response: PostResponse) throws {
        guard let userId = response.userId,
              let id = response.id,
              let title = response.title,
              let body = response.body else {
            throw JSONPlaceholderError.invalidData
        }
        
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    init(from entity: RMPost) throws {
        guard let userId = entity.userId,
              let id = entity.id,
              let title = entity.title,
              let body = entity.body else {
            throw JSONPlaceholderError.invalidData
        }
        
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    /// An example property that's used for Xcode previewing.
    static let example = Post(userId: 1,
                              id: 1,
                              title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                              body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
}

//MARK: - Mapping

extension Post {
    func asRealm() -> RMPost { return RMPost(from: self) }
}
