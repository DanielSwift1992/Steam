final class PlayerStatPresenter {

    // MARK: - Properties

    weak var view: PlayerStatViewInput?
    var router: PlayerStatRouterInput?

    // MARK: - Private Properties

    private let steamId: String
    private let game: Game

    private let interactor = PlayerStatInteractor()

    // MARK: - Initialization

    init(steamId: String, game: Game) {
        self.steamId = steamId
        self.game = game
    }
}

// MARK: - PlayerStatViewOutput

extension PlayerStatPresenter: PlayerStatViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        loadData()
    }

}

// MARK: - Private Methods

extension PlayerStatPresenter {

    func loadData() {
        view?.startLoading()
        interactor.getBadgeListAndGames(steamId: steamId, appId: game.appId) { [weak self] in
            self?.handleBadgePlayerStatResult(result: $0)
        }
    }

    func handleBadgePlayerStatResult(result: Result<[PlayerStat], Error>) {
        view?.stopLoading()

        switch result {
        case .success(let playerStat):
            view?.set(playerStat: playerStat)
        case .failure:
            view?.setEmptyState(true)
        }
    }

}
