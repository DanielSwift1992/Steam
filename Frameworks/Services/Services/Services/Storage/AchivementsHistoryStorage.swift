import RealmSwift

final class AchivementsHistoryStorage: BaseStorage { }

// MARK: - Methods

extension AchivementsHistoryStorage {

    func getCurrentUser() -> CurrentUserEntry? {
        get(CurrentUserEntry.self)?.first
    }

    func getOrCreatePlayerHistory(steamId: String) -> AchivementPlayerHistoryEntry? {
        guard let entry = get(AchivementPlayerHistoryEntry.self,
                              forPrimaryKey: steamId) else {
                                createAndSavePlayerHistory(steamId: steamId)
                                return nil
        }
        return entry
    }

    func save(steamId: String, appId: Int, achivements: [String]) {
        let historyItems = achivements.map {
            AchivementHistoryEntry(steamId: steamId, appId: appId, name: $0)
        }

        historyItems.forEach {
            guard get(AchivementHistoryEntry.self, forPrimaryKey: $0.id) == nil
                else { return }
            save($0)
        }
    }

    func updateHistoryEntry(steamId: String, with games: [Game]) {
        guard let historyEntry = getOrCreatePlayerHistory(steamId: steamId) else { return }
        let realm = try? Realm()

        realm?.writeOnBackground(object: historyEntry) { realm, entry in

            entry.lastUpdated = Date()

            games.forEach { gameToUpdate in
                defer {
                    entry.totalPlayed.append(.init(appId: gameToUpdate.appId,
                    time: gameToUpdate.playTime))
                }

                guard let index = entry.totalPlayed.firstIndex(where:
                    { $0.appId == gameToUpdate.appId }) else {
                        return
                }
                entry.totalPlayed.remove(at: index)
            }

            realm.add(entry, update: .modified)
        }
    }

    func setUpdatedPlayerHistory(steamId: String) {
        guard let entry = getOrCreatePlayerHistory(steamId: steamId) else { return }
        set(object: entry, path: \.lastUpdated, value: Date())
    }

}

// MARK: - Private xMethods

private extension AchivementsHistoryStorage {

    func createAndSavePlayerHistory(steamId: String) {
        let entry = AchivementPlayerHistoryEntry(steamId: steamId)
        save(entry)
    }

}
