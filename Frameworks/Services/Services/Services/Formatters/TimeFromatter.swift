final class TimeFormatter {

    // MARK: - Constants

    private enum Constants {
        static let hourFormat = "%d h"
        static let minutesInHour = 60
    }

}

extension TimeFormatter {

    static func minutesToHours(_ value: Int) -> String {
        .init(format: Constants.hourFormat, value / Constants.minutesInHour)
    }

}
