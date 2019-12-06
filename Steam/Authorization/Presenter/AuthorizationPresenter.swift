import WebKit

final class AuthorizationPresenter {

    // MARK: - Properties

    weak var view: AuthorizationViewInput?
    var router: AuthorizationRouterInput?
    var handler: BaseCompletion<SteamID>?

}

// MARK: - AuthorizationViewOutput

extension AuthorizationPresenter: AuthorizationViewOutput {

    func viewLoaded() {
        guard let url = UrlBuilder.getMobileURL() else {
            handler?(.failure(CommonError.dismissed))
            router?.dismiss()
            return
        }
        view?.setupInitialState(url: url)
    }

    func actionDidHappen(url: URL, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let steamId = SteamIdFormatter.convert(url: url) else {
            decisionHandler(.allow)
            return
        }

        decisionHandler(.cancel)
        handler?(.success(steamId))
        router?.dismiss()
    }

    func didFail(error: Error) {
        handler?(.failure(error))
        router?.dismiss()
    }

    func cancelTaped() {
        handler?(.failure(CommonError.dismissed))
        router?.dismiss()
    }

}
