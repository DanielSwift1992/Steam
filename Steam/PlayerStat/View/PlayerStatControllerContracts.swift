protocol PlayerStatViewInput: class, SpinnerViewLoadable, EmptyStateProvidable {
    var output: PlayerStatViewOutput? { get set }
    func setupInitialState()
    func set(playerStat: [PlayerStat])
}

protocol PlayerStatViewOutput {
    func viewLoaded()
}
