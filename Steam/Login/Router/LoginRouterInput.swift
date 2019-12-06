protocol LoginRouterInput: ErrorHandable {
    func openAuthorizationSteam(completion: @escaping BaseCompletion<SteamID>)
    func openMainFlow(player: Player)
}
