final class LoginPresenter {

    // MARK: - Properties

    weak var view: LoginViewInput?
    var router: LoginRouterInput?

    // MARK: - Private Properties

    private let playerService = PlayerService()
    private let vanityIdService = VanityIdService()
    private var userInfo: (steamId: String, name: String)? {
        playerService.getCurrentUserInfo()
    }

}

// MARK: - LoginViewOutput

extension LoginPresenter: LoginViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        setUserIfNeeded()
        authorizeUser()
    }

    func loginDidTap() {
        guard let steamId = userInfo?.steamId,
            !steamId.isEmpty else {
                anotherUserDidTap()
                return
        }
        loadCurrentUser(steamId: steamId)
    }

    func anotherUserDidTap() {
        router?.openAuthorizationSteam { [weak self] in
            self?.handleLoginSteam(result: $0)
        }
    }

}

// MARK: - Private Methods

private extension LoginPresenter {

    func setUserIfNeeded() {
        guard let name = userInfo?.name else { return }
        view?.set(name: name)
    }

    func handleLoginSteam(result: Result<SteamID, Error>) {
        guard let steamId = unwrapWithBaseHandler(result) else { return }

        switch steamId {
        case .id64(let steamId):
            loadCurrentUser(steamId: steamId)
        case .vanityID(let vanityURL):
            vanityIdService.getSteamId(vanityURL: vanityURL) { [weak self] in
                self?.vanityIdHandler(result: $0)
            }
        }
    }

    func loadCurrentUser(steamId: String) {
        view?.startLoading()

        playerService.requestAndSaveAsCurrentUser(from: steamId) { [weak self] in
            self?.handleUserSaving(result: $0)
        }
    }

    func handleUserSaving(result: Result<Player, Error>) {
        guard let player = unwrapWithBaseHandler(result) else { return }
        router?.openMainFlow(player: player)
    }

    func vanityIdHandler(result: Result<String, Error>) {
        guard let steamId = unwrapWithBaseHandler(result) else { return }
        loadCurrentUser(steamId: steamId)
    }

    func unwrapWithBaseHandler<T>(_ result: Result<T, Error>) -> T? {
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            view?.stopLoading()
            router?.handle(error)
            return nil
        }
    }

}
