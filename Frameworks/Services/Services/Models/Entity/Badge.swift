public struct Badge {

    public let badgeId: Int

    // MARK: - Initialization

    init(entry: BadgeEntry) {
        self.badgeId = entry.badgeId
    }

}
