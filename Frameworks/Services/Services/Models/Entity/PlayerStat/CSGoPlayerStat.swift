public struct CSGoPlayerStat {

    // MARK: - Enum

    public enum StatType {
        case killDeathRate, killes, timePlayed, winRate, accuracyRate, headshotsRate, mvp
    }

    // MARK: - Properties

    public let value: String
    public let statType: StatType

}
