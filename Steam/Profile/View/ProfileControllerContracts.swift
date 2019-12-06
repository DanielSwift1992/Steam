protocol ProfileViewInput: class, SpinnerViewLoadable, EmptyStateProvidable {
    func setupInitialState()
    func set(headerModel: ProfileHeaderView.Model, games: [Game])
}

protocol ProfileViewOutput: ProfileHeaderViewDelegate, ProfileAdapterDelegate {
    func viewLoaded()
}
