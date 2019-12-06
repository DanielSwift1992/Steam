struct ResponseEntry<T: Codable>: Codable {

    let response: T

    enum CodingKeys: String, CodingKey {
        case response
    }

}
