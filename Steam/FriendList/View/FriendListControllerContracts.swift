protocol FriendListViewInput: class, SpinnerViewLoadable, EmptyStateProvidable {
    func setupInitialState()
    func set(friends: [Player])
}

protocol FriendListViewOutput: FriendListAdapterDelegate {
    func viewLoaded()
}
