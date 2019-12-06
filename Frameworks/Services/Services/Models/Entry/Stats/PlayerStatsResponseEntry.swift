struct PlayerStatsResponseEntry: Codable {

    let playerstats: PlayerStatListEntry

    enum CodingKeys: String, CodingKey {
        case playerstats
    }

}
