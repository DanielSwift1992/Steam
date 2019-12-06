public struct Player {

    public let steamId: String
    public let personaName: String
    public let avatarURL: URL?

    init(entry: PlayerEntry) {
        self.steamId = entry.steamId
        self.personaName = entry.personaName ?? ""
        self.avatarURL = URL(string: entry.avatarFull ?? entry.avatarMedium ?? entry.avatar ?? "")
    }

}
