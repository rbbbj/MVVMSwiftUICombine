struct User: Identifiable {
    private(set) var id: Int
    private(set) var name: String
    private(set) var username: String
    private(set) var email: String
    private(set) var phone: String
    private(set) var website: String
    private(set) var address: Address
    private(set) var company: Company
    
    init(id: Int,
         name: String,
         username: String,
         email: String,
         phone: String,
         website: String,
         address: Address,
         company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
    
    init(from response: UserResponse) throws {
        guard let id = response.id,
              let name = response.name,
              let username = response.username,
              let email = response.email,
              let phone = response.phone,
              let website = response.website else {
            throw JSONPlaceholderError.invalidData
        }
        
        guard let geo = response.address?.geo,
              let lat = geo.lat,
              let lng = geo.lng else {
            throw JSONPlaceholderError.invalidData
        }
        let location = Location(lat: lat, lng: lng)
        
        guard let street = response.address?.street,
              let suite = response.address?.suite,
              let city = response.address?.city,
              let zipcode = response.address?.zipcode else {
            throw JSONPlaceholderError.invalidData
        }
        let address = Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: location)
        
        guard let companyName = response.company?.name,
              let catchPhrase = response.company?.catchPhrase,
              let bs = response.company?.bs else {
            
            throw JSONPlaceholderError.invalidData
        }
        let company = Company(name: companyName, catchPhrase: catchPhrase, bs: bs)
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
    
    init(from entity: RMUser) throws {
        guard let id = entity.id,
              let name = entity.name,
              let username = entity.username,
              let email = entity.email,
              let phone = entity.phone,
              let website = entity.website,
              let address = try entity.address?.asDomain(),
              let company = try entity.company?.asDomain() else {
            throw JSONPlaceholderError.invalidData
        }
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
    

    
}

//MARK: - mockUser

extension User {
    static let mockUser = User(id: 9,
                               name: "Glenna Reichert",
                               username: "Delphine",
                               email: "Chaim_McDermott@dana.io",
                               phone: "(775)976-6794 x41206",
                               website: "conrad.com",
                               address: Address(street: "Dayna Park", suite: "Suite 449", city: "Bartholomebury", zipcode: "76495-3109", geo: Location(lat: "24.6463", lng: "-168.8889")),
                               company: Company(name: "Yost and Sons", catchPhrase: "Switchable contextually-based project", bs: "aggregate real-time technologies"))
}

//MARK: - Mapping

extension User {
    func asRealm() -> RMUser { return RMUser(from: self) }
}

//MARK: - Hashable

extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
    

//MARK: - Helpers

extension User {
    mutating func set(phone newPhone: String) {
        phone = newPhone
    }
    
    mutating func set(address newAddress: Address) {
        address = newAddress
    }
}
