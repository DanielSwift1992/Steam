public struct CSGoPlayerStatList {

    // MARK: - Typealias

    typealias FullStat = CSGoPlayerFullStatEntry

    // MARK: - Constants

    private enum Constants {
        static let percentFormat = "%.1f%%"
        static let hourFormat = "%dh"
        static let secondsInHour = 3600
        static let percent = 100.0
    }

    // MARK: - Properties

    public private(set) var stat: [CSGoPlayerStat] = []

    // MARK: - Initialization

    public init(playerStat: [PlayerStat]) {
        generateStat(from: playerStat)
    }

}

private extension CSGoPlayerStatList {

    mutating func generateStat(from playerStat: [PlayerStat]) {
        guard let fullStatEntry = getFullStatEntry(from: playerStat) else {
            return
        }

        setPercent(fullStat: fullStatEntry, type: .killDeathRate,
                   from: \.totalKills, and: \.totalDeaths)

        setValue(fullStat: fullStatEntry, type: .killes, from: \.totalKills)
        setHours(fullStat: fullStatEntry, type: .timePlayed, from: \.totalTimePlayed)

        setPercent(fullStat: fullStatEntry, type: .winRate,
                   from: \.totalMatchesWon, and: \.totalMatchesPlayed)

        setPercent(fullStat: fullStatEntry, type: .accuracyRate,
                   from: \.totalShotsHit, and: \.totalShotsFired)

        setValue(fullStat: fullStatEntry, type: .mvp, from: \.totalMvps)

        setPercent(fullStat: fullStatEntry, type: .headshotsRate,
                   from: \.totalKillsHeadshot, and: \.totalKills)
    }

    func getFullStatEntry(from playerStat: [PlayerStat]) -> FullStat? {
        guard let statDictionary = getStatDictionary(from: playerStat),
            let jsonData = try? JSONSerialization.data(withJSONObject: statDictionary,
                                                       options: .prettyPrinted) else {
                                                        return nil
        }
        return try? JSONDecoder().decode(FullStat.self, from: jsonData)
    }

    func getStatDictionary(from playerStat: [PlayerStat]) -> [String: Double]? {
        let stat = playerStat.map{ ($0.id, $0.value) }
        return .init(Dictionary(uniqueKeysWithValues: stat))
    }

    mutating func setPercent(fullStat: FullStat,
                             type: CSGoPlayerStat.StatType,
                             from fristPath: KeyPath<FullStat, Double?>,
                             and secondPath: KeyPath<FullStat, Double?>) {

        guard let firstValue = fullStat[keyPath: fristPath],
            let secondValue = fullStat[keyPath: secondPath] else {
                return
        }

        let value = String(format: Constants.percentFormat,
                           Constants.percent * firstValue / secondValue)
        stat.append(.init(value: value, statType: type))
    }

    mutating func setValue(fullStat: FullStat,
                           type: CSGoPlayerStat.StatType,
                           from fristPath: KeyPath<FullStat, Double?>) {

        guard let value = fullStat[keyPath: fristPath] else { return }
        stat.append(.init(value: value.removedTrailingZero, statType: type))
    }

    mutating func setHours(fullStat: FullStat,
                           type: CSGoPlayerStat.StatType,
                           from fristPath: KeyPath<FullStat, Double?>) {

        guard let value = fullStat[keyPath: fristPath] else { return }

        let hours = String(format: Constants.hourFormat,
                           Int(value) / Constants.secondsInHour)
        stat.append(.init(value: hours, statType: type))
    }

}
