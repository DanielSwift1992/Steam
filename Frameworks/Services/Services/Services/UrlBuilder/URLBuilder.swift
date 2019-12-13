public final class UrlBuilder {

    // MARK: - Constants

    private enum Constants {
        static let apiKeyParameter = "key=160A1E87653E30D9562DE9E5A47386E5"
        static let baseURL = "https://api.steampowered.com"
        static let mobileURL = "https://steamcommunity.com/mobilelogin"
    }

}

// MARK: - Methods

public extension UrlBuilder {

    static func getMobileURL() -> URL? {
        URL(string: Constants.mobileURL)
    }

    static func getResolveVanityURL(_ vanityURL: String) -> URL? {
        URL(string:
            Constants.baseURL
                + "/ISteamUser/ResolveVanityURL/v0001/?"
                + Constants.apiKeyParameter
                + "&vanityurl="
                + vanityURL
        )
    }

    static func getPlayersURL(_ ids: [String]) -> URL? {
        URL(string:
            Constants.baseURL
                + "/ISteamUser/GetPlayerSummaries/v0002/?"
                + Constants.apiKeyParameter
                + "&steamids="
                + "[\(ids.joined(separator: ","))]"
        )
    }

    static func getOwnedGamesURL(_ id: String) -> URL? {
        URL(string:
            Constants.baseURL
                + "/IPlayerService/GetOwnedGames/v0001/?"
                + Constants.apiKeyParameter
                + "&steamid="
                + id
                + "&include_appinfo=true&include_played_free_games=true"
        )
    }

    static func getAppListURL(_ ids: [String]) -> URL? {
        URL(string: "https://api.steampowered.com/ISteamApps/GetAppList/v2/")
    }

    static func getUserStatsForGameURL(_ steamId: String, appId: Int) -> URL? {
        URL(string:
            Constants.baseURL
                + "/ISteamUserStats/GetUserStatsForGame/v2/?"
                + Constants.apiKeyParameter
                + "&steamid="
                + steamId
                + "&appid="
                + String(appId)
        )
    }

    static func getGameSchemaURL(_ appId: Int) -> URL? {
        URL(string:
            Constants.baseURL
                + "/ISteamUserStats/GetSchemaForGame/v2/?"
                + Constants.apiKeyParameter
                + "&appid="
                + String(appId)
        )
    }

    static func getRecentlyPlayedGamesURL(steamId: String) -> URL? {
        URL(string:
            Constants.baseURL
                + "/IPlayerService/GetRecentlyPlayedGames/v0001/?"
                + Constants.apiKeyParameter
                + "&steamid="
                + steamId
        )
    }

    static func getImageURL(appId: Int, hash: String) -> URL? {
        URL(string:
            "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/apps/"
                + String(appId)
                + "/"
                + hash
                + ".jpg"
        )
    }

    static func getFriendsURL(_ id: String) -> URL? {
        URL(string:
            Constants.baseURL
                + "/ISteamUser/GetFriendList/v0001/?"
                + Constants.apiKeyParameter
                + "&steamid="
                + id
                + "&relationship=friend"
        )
    }

    static func getBadgesURL(_ id: String) -> URL? {
        URL(string:
            Constants.baseURL
                + "/IPlayerService/GetBadges/v1/?"
                + Constants.apiKeyParameter
                + "&steamid="
                + id
        )
    }

}
