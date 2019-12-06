public struct Game {

    public let appId: Int
    public let name: String
    public let iconUrl: URL?
    public let logoUrl: URL?
    public let playTime: Int
    public let playTimeHoursRepresentation: String
    public let playTimeFor2Weeks: String

    // MARK: - Initialization

    init(entry: GameEntry) {
        self.appId = entry.appId
        self.name = entry.name ?? ""
        self.iconUrl = UrlBuilder.getImageURL(appId: entry.appId, hash: entry.iconUrl ?? "")
        self.logoUrl = UrlBuilder.getImageURL(appId: entry.appId, hash: entry.logoUrl ?? "")
        self.playTime = entry.playTime ?? 0
        self.playTimeHoursRepresentation = TimeFormatter.minutesToHours(entry.playTime ?? 0)
        self.playTimeFor2Weeks = TimeFormatter.minutesToHours(entry.playTimeFor2Weeks ?? 0)
    }
    
}
