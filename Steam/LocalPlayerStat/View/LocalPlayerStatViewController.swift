import Charts

final class LocalPlayerStatViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let chartAnimationDuration: TimeInterval = 0.8
        static let gridColor = Theme.subText.withAlphaComponent(0.15)
    }

    // MARK: - Properties

    var output: LocalPlayerStatViewOutput?

    // MARK: - Private Properties

    private var pickerData = [Game]()

    // MARK: - Subviews

    private let inputTextField = UITextField()
    private let chartView = BarChartView()
    private var pickerView = UIPickerView()
    private lazy var emptyStateView = EmptyStateView(superview: view)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - LocalPlayerStatViewInput

extension LocalPlayerStatViewController: LocalPlayerStatViewInput {

    func setupInitialState() {
        appendSubviews()
        setConstraints()
        configureViews()
        setDelegates()
    }

    func set(pickerData: [Game]) {
        self.pickerData = pickerData
        pickerView.reloadAllComponents()
        setInputText()
        selecetFirstIfNeeded()
    }

    func set(models: [ChartDataModel<Date>]) {
        let entries = models.map {
            BarChartDataEntry(x: $0.x, y: $0.y, data: $0.data)
        }

        let set = BarChartDataSet(entries: entries).apply {
            $0.drawValuesEnabled = false
            $0.highlightEnabled = false
            $0.colors = [Theme.chartColor]
        }

        chartView.data = BarChartData(dataSet: set).apply {
            $0.barWidth = 0.8
        }

        chartView.animate(yAxisDuration: Constants.chartAnimationDuration,
                          easingOption: .easeInCubic)
    }

    func setEmptyState(_ isEmpty: Bool) {
        emptyStateView.setVisabilityAnimated(isHidden: !isEmpty, delay: 0.1)
        [chartView, inputTextField].forEach { $0.isHidden = isEmpty }
    }

}

// MARK: - Actions

private extension LocalPlayerStatViewController {

    @objc
    func dismissPicker() {
        inputTextField.endEditing(true)
    }

}


// MARK: - Private Methods

private extension LocalPlayerStatViewController {

    func configureViews() {
        chartView.apply {
            $0.drawBarShadowEnabled = false
            $0.drawValueAboveBarEnabled = false
            $0.chartDescription?.enabled = false
            $0.dragEnabled = true
            $0.doubleTapToZoomEnabled = false
            $0.setScaleEnabled(true)
            $0.pinchZoomEnabled = true
            $0.legend.enabled = false
            $0.rightAxis.enabled = false
            $0.maxVisibleCount = 12
            $0.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
            )
        }

        chartView.xAxis.apply {
            $0.labelPosition = .bottom
            $0.labelFont = .systemFont(ofSize: 10)
            $0.labelCount = 7
            $0.granularity = 1
            $0.labelTextColor = Theme.subText
            $0.gridColor = Constants.gridColor
            $0.axisLineColor = Constants.gridColor
            $0.valueFormatter = ChartXAxisDateFormatter { [weak self] in
                self?.getDate(from: $0)
            }
        }

        chartView.leftAxis.apply {
            $0.labelFont = .systemFont(ofSize: 10)
            $0.labelCount = 4
            $0.labelPosition = .outsideChart
            $0.spaceTop = 0.15
            $0.axisMinimum = 0
            $0.labelTextColor = Theme.subText
            $0.gridColor = Constants.gridColor
            $0.axisLineColor = Constants.gridColor
            $0.valueFormatter = DefaultAxisValueFormatter(formatter: getLeftAxisFormatter())
        }

        inputTextField.apply {
            $0.inputView = pickerView
            $0.textColor = Theme.textTitle
            $0.backgroundColor = .clear
            $0.tintColor = .clear
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20)
        }

        inputTextField.layer.apply {
            $0.cornerRadius = 4
            $0.borderColor = Theme.subText.withAlphaComponent(0.5).cgColor
            $0.borderWidth = 0.5
        }

        view.apply {
            $0.backgroundColor = Theme.mainBackground
            $0.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
            )
        }

        title = L10n.Statistics.title
    }

    func setDelegates() {
        pickerView.apply {
            $0.delegate = self
            $0.dataSource = self
        }
    }

    func getLeftAxisFormatter() -> NumberFormatter {
        NumberFormatter().apply {
            $0.minimumFractionDigits = 0
            $0.maximumFractionDigits = 1
        }
    }

    func setInputText() {
        inputTextField.text = pickerData.first?.name
    }

    func selecetFirstIfNeeded() {
        guard let element = pickerData.first else { return }
        output?.didSelect(element: element)
    }

    func getDate(from value: Double) -> Date? {
        let set = chartView.data?.dataSets.first
        let entry = set?.entriesForXValue(value).first as? BarChartDataEntry
        return entry?.data as? Date
    }

}

// MARK: - Layout

private extension LocalPlayerStatViewController {

    func appendSubviews() {
        view.add(subviews: chartView, inputTextField)
    }

    func setConstraints() {
        inputTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaInsets.top).offset(16)
            } else {
                $0.top.equalToSuperview().offset(16)
            }
        }

        chartView.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(view.safeAreaInsets.bottom).offset(-16)
            } else {
                $0.bottom.equalToSuperview().offset(-16)
            }
        }
    }

}

// MARK: - UIPickerViewDelegate

extension LocalPlayerStatViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {

        guard let element = pickerData[safe: row] else { return }
        output?.didSelect(element: element)
        inputTextField.text = element.name
        dismissPicker()
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        pickerData[row].name
    }

}

// MARK: - UIPickerViewDelegate

extension LocalPlayerStatViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }

}
