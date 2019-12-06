import Charts

public class ChartXAxisDateFormatter: NSObject {

    // MARK: - Constants

    public enum Constants {
        static public let defaultFormat = "LLLL"
    }

    // MARK: - Private Properties

    private let format: String
    private let dateProvider: (Double) -> Date?
    private let dateFormatter = DateFormatter()

    // MARK: - Initialization

    public init(format: String = Constants.defaultFormat,
                dateProvider: @escaping (Double) -> Date?) {

        self.format = format
        self.dateProvider = dateProvider
        dateFormatter.dateFormat = format
    }
}

// MARK: - IAxisValueFormatter

extension ChartXAxisDateFormatter: IAxisValueFormatter {

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let date = dateProvider(value) else {
            return ""
        }
        return dateFormatter.string(from: date)
    }

}
