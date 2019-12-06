import WebKit

protocol AuthorizationViewInput: class {
    func setupInitialState(url: URL)
}

protocol AuthorizationViewOutput {
    func viewLoaded()
    func actionDidHappen(url: URL,
                         decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    func didFail(error: Error)
    func cancelTaped()
}
