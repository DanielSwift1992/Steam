import UIKit
import WebKit

final class AuthorizationViewController: UIViewController {

    // MARK: - Properties

    var output: AuthorizationViewOutput?

    // MARK: - Private Properties

    var webView: WKWebView!

    private let userButton = UIButton()

    // MARK: - UIViewController

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - AuthorizationViewInput

extension AuthorizationViewController: AuthorizationViewInput {

    func setupInitialState(url: URL) {
        configureNavigationBar()
        webView.load(.init(url: url))
    }

}

// MARK: - Actions

private extension AuthorizationViewController {

    @objc
    func onCancelTaped() {
        output?.cancelTaped()
    }

}

// MARK: - WKNavigationDelegate

extension AuthorizationViewController: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }

        output?.actionDidHappen(url: url, decisionHandler: decisionHandler)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        output?.didFail(error: error)
    }

}

// MARK: - Private Methods

private extension AuthorizationViewController {

    func configureNavigationBar() {
        navigationController?.removeTheShadow()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: L10n.Authorization.BarButton.cancel,
            style: .plain,
            target: self,
            action: #selector(onCancelTaped)
        )
    }

}
