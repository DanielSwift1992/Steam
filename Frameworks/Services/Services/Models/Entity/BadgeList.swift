public struct BadgeList {

    public let badges: [Badge]
    public let level: Int
    public let xp: Double
    public let xpNeededToLevelUp: Double
    public let xpNeededCurrentLevel: Double

    public var xpNeededNextLevel: Double {
        xp - xpNeededCurrentLevel + xpNeededToLevelUp
    }

    public var xpNeededPercent: Double {
        1 - xpNeededToLevelUp / xpNeededNextLevel
    }

    // MARK: - Initialization

    init(entry: BadgesListEntry) {
        self.badges = entry.badges?.compactMap(Badge.init) ?? []
        self.level = entry.playerLevel ?? 0
        self.xp = .init(entry.playerXp ?? 0)
        self.xpNeededToLevelUp = .init(entry.playerXpNeededToLevelUp ?? 0)
        self.xpNeededCurrentLevel = .init(entry.playerXpNeededCurrentLevel ?? 0)
    }

}
