final class FriendListPresenter {

    // MARK: - Properties

    weak var view: FriendListViewInput?
    var router: FriendListRouterInput?

    // MARK: - Private Properties

    private let steamId: String
    private let interactor = FirendListInteractor()

    // MARK: - Initialization

    init(steamId: String) {
        self.steamId = steamId
    }

}

// MARK: - FriendListViewOutput

extension FriendListPresenter: FriendListViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        loadData()
    }

    func didSelect(item: Player) {
        router?.openProfile(player: item)
    }

}

// MARK: - Private Methods

private extension FriendListPresenter {

    func loadData() {
        view?.startLoading()
        interactor.getFriendList(steamId: steamId) { [weak self] in
            self?.handleFriendList(result: $0)
        }
    }

    func handleFriendList(result: Result<[Player], Error>) {
        view?.stopLoading()

        switch result {
        case .success(let firends):
            let players = firends.sorted(by: \.personaName)
            players.isEmpty ? view?.setEmptyState(true) : view?.set(friends: players)
        case .failure:
            view?.setEmptyState(true)
        }
    }

}
