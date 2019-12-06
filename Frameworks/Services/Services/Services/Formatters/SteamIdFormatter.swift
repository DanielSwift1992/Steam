public final class SteamIdFormatter {

    // MARK: - Constants

    private enum Constants {
        static var profiles: String { #function }
        static var id: String { #function }
        static let indexIncrement = 1
    }

}

// MARK: - Methods

public extension SteamIdFormatter {

    static func convert(url: URL) -> SteamID? {
        let steamComponents = zip([SteamID.id64, SteamID.vanityID],
                                  [Constants.profiles, Constants.id])

        for (steamID, component) in steamComponents {
            guard let id = getID(from: url, for: component) else { continue }
            return steamID(id)
        }

        return nil
    }

}

// MARK: - Private Methods

private extension SteamIdFormatter {

    static func getID(from url: URL, for component: String) -> String? {
        let elements = url.pathComponents
        guard let index = elements.firstIndex(where: { $0 == component }) else {
            return nil
        }

        return elements[safe: index + Constants.indexIncrement]
    }

}
