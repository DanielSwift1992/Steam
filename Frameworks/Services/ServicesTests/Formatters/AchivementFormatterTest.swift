import XCTest
@testable import Services

class AchivementFormatterTest: XCTestCase {

    private enum Constants {
        static let dateFormat = "2019-%@-%@T10:44:00+0000"
    }

    private let dateFormatter = ISO8601DateFormatter()

    private lazy var achimevemnts = [
        getAchivement(day: "01", month: "09"),
        getAchivement(day: "01", month: "09"),
        getAchivement(day: "02", month: "11"),
        getAchivement(day: "03", month: "11"),
        getAchivement(day: "01", month: "12"),
    ]

    private lazy var expectedResult = [
        ChartDataModel(x: 1, y: 2, data: getDate(day: "01", month: "09")),
        ChartDataModel(x: 3, y: 2, data: getDate(day: "02", month: "11")),
        ChartDataModel(x: 4, y: 1, data: getDate(day: "01", month: "12")),
    ]

    func test() {
        let dateModels = AchivementFormatter()
            .convert(achivements: achimevemnts, by: .month)

        (0 ..< dateModels.count).forEach {
            XCTAssertEqual(dateModels[$0], expectedResult[$0])
        }

        XCTAssertEqual(dateModels.count, expectedResult.count)
    }

}

// MARK: - Private Methods

private extension AchivementFormatterTest {

    private func getAchivement(day: String, month: String) -> Achivement {
        let entry = AchivementHistoryEntry()
        entry.date = getDate(day: day, month: month)
        return .init(entry: entry)
    }

    func getDate(day: String, month: String) -> Date {
        let dateString = String(format: Constants.dateFormat, month, day)
        return dateFormatter.date(from: dateString)!
    }

}
