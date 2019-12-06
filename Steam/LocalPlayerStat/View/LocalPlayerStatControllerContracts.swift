protocol LocalPlayerStatViewInput: class, EmptyStateProvidable {
    func setupInitialState()
    func set(models: [ChartDataModel<Date>])
    func set(pickerData: [Game])
}

protocol LocalPlayerStatViewOutput {
    func viewLoaded()
    func didSelect(element: Game)
}
