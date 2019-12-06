import UIKit
import Common

final class LoginViewController: UIViewController {

    // MARK: - Properties

    var output: LoginViewOutput?

    // MARK: - Subviews

    private let logoGradientView = GradientImageView()
    private let titleLabel = UILabel()
    private let loginButton = GradientButton()
    private let anotherUserButton = UIButton()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {

    func setupInitialState() {
        configureViews()
        configureNavigationBar()
        appendSubviews()
        setConstraints()
        setViewsVisability(isUserIdentified: false)
    }

    func set(name: String) {
        titleLabel.text = L10n.Login.greatingsUser(name)
        setViewsVisability(isUserIdentified: true)
    }

    func startLoading() {
        logoGradientView.startAnimation()
        setViewsIsEnabled(false)
    }

    func stopLoading() {
        logoGradientView.stopAnimation()
        setViewsIsEnabled(true)
    }

}

// MARK: - Actions

private extension LoginViewController {

    @objc
    func loginButtonDidTap() {
        output?.loginDidTap()
    }

    @objc
    func anotherUserButtonDidTap() {
        output?.anotherUserDidTap()
    }

}

// MARK: - Private Methods

private extension LoginViewController {

    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func configureViews() {
        logoGradientView.image = CommonAsset.Login.steamLogo.image

        titleLabel.apply {
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 32, weight: .light)
            $0.textColor = Theme.subText
            $0.text = L10n.Login.greatings
            $0.textAlignment = .center
        }

        loginButton.apply {
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
            $0.setTitle(L10n.Login.Button.login, for: .normal)
            $0.setTitleColor(Theme.subText, for: .highlighted)
            $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        }

        anotherUserButton.apply {
            $0.contentHorizontalAlignment = .right
            $0.setTitleColor(Theme.subText, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
            $0.setTitle(L10n.Login.Button.anotherUser, for: .normal)
            $0.addTarget(self, action: #selector(anotherUserButtonDidTap),
                         for: .touchUpInside)
        }

        view.backgroundColor = Theme.mainBackground
    }

    func setViewsVisability(isUserIdentified: Bool) {
        anotherUserButton.isHidden = !isUserIdentified
    }

    func setViewsIsEnabled(_ isEnabled: Bool) {
        [loginButton, anotherUserButton].forEach { $0.isEnabled = isEnabled }
    }

}

// MARK: - Layout

private extension LoginViewController {

    func appendSubviews() {
        view.add(subviews: logoGradientView, titleLabel, loginButton, anotherUserButton)
    }

    func setConstraints() {
        loginButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(46)
            $0.right.equalToSuperview().offset(-46)
            $0.height.equalTo(46)
        }

        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(loginButton.snp.top).offset(-52)
        }

        logoGradientView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
            $0.bottom.equalTo(loginButton.snp.top).offset(-172)
        }

        anotherUserButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.width.equalTo(loginButton)
            $0.height.equalTo(28)
        }
    }

}
