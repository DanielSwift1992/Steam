struct CSGoPlayerFullStatEntry: Codable {

    let totalKills: Double?
    let totalTimePlayed: Double?
    let totalMatchesWon: Double?
    let totalMatchesPlayed: Double?
    let totalShotsHit: Double?
    let totalShotsFired: Double?
    let totalMvps: Double?
    let totalKillsHeadshot: Double?
    let totalDeaths: Double?

    enum CodingKeys: String, CodingKey {
        case totalKills = "total_kills"
        case totalTimePlayed = "total_time_played"
        case totalMatchesWon = "total_matches_won"
        case totalMatchesPlayed = "total_matches_played"
        case totalShotsHit = "total_shots_hit"
        case totalShotsFired = "total_shots_fired"
        case totalMvps = "total_mvps"
        case totalKillsHeadshot = "total_kills_headshot"
        case totalDeaths = "total_deaths"
    }

}
