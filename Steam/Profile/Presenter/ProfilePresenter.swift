final class ProfilePresenter {

    // MARK: - Properties

    weak var view: ProfileViewInput?
    var router: ProfileRouterInput?

    // MARK: - Private Properties

    private let player: Player
    private var badgeList: BadgeList?
    private var games = [Game]()
    private let interactor = ProfileInteractor()

    // MARK: - Initialization

    init(player: Player) {
        self.player = player
    }

}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        loadData()
    }

    func onStatisticTap() {
        router?.openStatistic(steamId: player.steamId, games: games)
    }

    func onFriendsTap() {
        router?.openFriendsList(steamId: player.steamId)
    }

    func didSelect(item: Game) {
        router?.openPlayerStatistic(steamId: player.steamId, game: item)
    }

}

// MARK: - Private Methods

private extension ProfilePresenter {

    func loadData() {
        view?.startLoading()
        interactor.getBadgeListAndGames(steamId: player.steamId ) { [weak self] in
            self?.handleBadgeListAndGamesResult(result: $0)
        }
    }

    func handleBadgeListAndGamesResult(result: Result<(BadgeList, [Game]), Error>) {
        view?.stopLoading()

        switch result {
        case .success(let list, let games):
            self.games = games
            setForView(badgeList: list, games: games)
        case .failure:
            view?.setEmptyState(true)
        }
    }

    func setForView(badgeList: BadgeList, games: [Game]) {
        let model = ProfileHeaderView.Model(steamId: player.steamId,
                                            name: player.personaName,
                                            avatarURL: player.avatarURL,
                                            level: L10n.Profile.level(badgeList.level),
                                            nextLevelPercent: badgeList.xpNeededPercent)

        view?.set(headerModel: model, games: games)
    }
    
}
