struct CompanyResponse {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

extension CompanyResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decodeIfPresent(String.self, forKey: .name)
        catchPhrase = try container.decodeIfPresent(String.self, forKey: .catchPhrase)
        bs = try container.decodeIfPresent(String.self, forKey: .bs)
    }
}
