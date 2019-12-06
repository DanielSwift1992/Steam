protocol ProfileRouterInput {
    func openStatistic(steamId: String, games: [Game])
    func openFriendsList(steamId: String)
    func openPlayerStatistic(steamId: String, game: Game)
}
