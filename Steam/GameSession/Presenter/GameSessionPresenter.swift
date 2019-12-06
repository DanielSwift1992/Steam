final class GameSessionPresenter {

    // MARK: - Properties

    weak var view: GameSessionViewInput?
    var router: GameSessionRouterInput?

    // MARK: - Private Properties

    private let steamId: String
    private let recentlyPlayedService = RecentlyPlayedGamesService()

    // MARK: - Initialization

    init(steamId: String) {
        self.steamId = steamId
    }

}

// MARK: - GameSessionViewOutput

extension GameSessionPresenter: GameSessionViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        loadPlayedGames()
    }

}

// MARK: - Private Methods

extension GameSessionPresenter {

    func loadPlayedGames() {
        view?.startLoading()

        recentlyPlayedService.getGames(steamId: steamId) { [weak self] in
            self?.handleGamesLoading(result: $0)
        }
    }

    func handleGamesLoading(result: Result<[Game], Error>) {
        view?.stopLoading()

        switch result {
        case .success(let games):
            games.isEmpty ? view?.setEmptyState(true) : view?.set(games: games)
        case .failure:
            view?.setEmptyState(true)
        }
    }

}
