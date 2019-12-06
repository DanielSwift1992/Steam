final class LocalPlayerStatPresenter {

    // MARK: - Properties

    weak var view: LocalPlayerStatViewInput?
    var router: LocalPlayerStatRouterInput?
    let statService = PlayerAchivementLocalStatService()

    // MARK: - Private Properties

    private let steamId: String
    private var games: [Game]

    // MARK: - Initialization

    init(steamId: String, games: [Game]) {
        self.steamId = steamId
        self.games = games
    }

}

// MARK: - LocalPlayerStatViewOutput

extension LocalPlayerStatPresenter: LocalPlayerStatViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        loadAvailableAppIds()
    }

    func didSelect(element: Game) {
        setAchivements(for: element.appId)
    }

}

// MARK: - Private Methods

private extension LocalPlayerStatPresenter {

    func loadAvailableAppIds() {
        let appIds = statService.getAvailableAppIds(steamId: steamId)
        self.games = games.filter { appIds.contains($0.appId) }

        games.isEmpty ? view?.setEmptyState(true) : view?.set(pickerData: games)
    }

    func setAchivements(for appId: Int) {
        let achivements = statService.getAchivements(steamId: steamId,
                                                     appId: appId,
                                                     by: .month)
        view?.set(models: achivements)
    }

}
