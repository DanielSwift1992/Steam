struct PlayerAchivementResponseEntry: Codable {

    let playerstats: PlayerAchivementListEntry

    enum CodingKeys: String, CodingKey {
        case playerstats
    }

}
