struct Company {
    let name: String
    let catchPhrase: String
    let bs: String
    
    init(name: String,
         catchPhrase: String,
         bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    init(from response: CompanyResponse) throws {
        guard let name = response.name,
        let catchPhrase = response.catchPhrase,
        let bs = response.bs else {
            throw JSONPlaceholderError.invalidData
        }
        
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }

    init(from entity: RMCompany) throws {
        guard let name = entity.name,
            let catchPhrase = entity.catchPhrase,
            let bs = entity.bs else {
                throw JSONPlaceholderError.invalidData
        }

        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}

extension Company {
    func asRealm() -> RMCompany { return RMCompany(from: self) }
}
