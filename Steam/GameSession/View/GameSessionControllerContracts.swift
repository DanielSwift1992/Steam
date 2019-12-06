protocol GameSessionViewInput: class, SpinnerViewLoadable, EmptyStateProvidable {
    func setupInitialState()
    func set(games: [Game])
}

protocol GameSessionViewOutput {
    func viewLoaded()
}
