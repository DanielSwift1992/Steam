struct PlayerEntry: Codable {

    let steamId: String
    let personaName: String?
    let profileURL: String?
    let avatar: String?
    let avatarMedium: String?
    let avatarFull: String?
    let realName: String?
    let primaryClanid: String?
    let localCountryCode: String?
    let localStatecode: String?

    let communityVisibilityState: Int?
    let profileState: Int?
    let lastLogo: Int?
    let commentPermission: Int?
    let personaState: Int?
    let timeCreated: Int?
    let personaStateFlags: Int?
    let localCityId: Int?

    enum CodingKeys: String, CodingKey {
        case steamId = "steamid"
        case personaName = "personaname"
        case profileURL = "profileurl"
        case avatar = "avatar"
        case avatarMedium = "avatarmedium"
        case avatarFull = "avatarfull"
        case realName = "realname"
        case primaryClanid = "primaryclanid"
        case localCountryCode = "loccountrycode"
        case localStatecode = "locstatecode"
        case communityVisibilityState = "communityvisibilitystate"
        case profileState = "profilestate"
        case lastLogo = "lastlogoff"
        case commentPermission = "commentpermission"
        case personaState = "personastate"
        case timeCreated = "timecreated"
        case personaStateFlags = "personastateflags"
        case localCityId = "loccityid"
    }

}
