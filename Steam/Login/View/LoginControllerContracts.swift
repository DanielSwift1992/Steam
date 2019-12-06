protocol LoginViewInput: class {
    func setupInitialState()
    func set(name: String)
    func startLoading()
    func stopLoading()
}

protocol LoginViewOutput {
    func viewLoaded()
    func loginDidTap()
    func anotherUserDidTap()
}
