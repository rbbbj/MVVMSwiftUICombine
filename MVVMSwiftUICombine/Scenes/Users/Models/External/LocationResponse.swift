struct LocationResponse {
    let lat: String?
    let lng: String?
}

extension LocationResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
    }
}
