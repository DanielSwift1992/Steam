public struct Achivement {

    let name: String
    let date: Date

    // MARK: - Initialization

    init(entry: AchivementHistoryEntry) {
        self.name = entry.name
        self.date = entry.date
    }

}
