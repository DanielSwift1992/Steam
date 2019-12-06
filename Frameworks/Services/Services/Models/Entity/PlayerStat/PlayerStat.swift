public struct PlayerStat {

    public let id: String
    public let name: String?
    public let value: Double
    public let valueRepresentation: String

    // MARK: - Initialization

    init(entry: PlayerStatEntry) {
        self.id = entry.name
        self.name = ""
        self.value = entry.value
        self.valueRepresentation = ""
    }

    public init(playerStat: PlayerStat, name: String?) {
        self.id = playerStat.id
        self.value = playerStat.value
        self.name = name
        self.valueRepresentation = PlayerStatValueFormatter.convert(playerStat.value)
    }

}
