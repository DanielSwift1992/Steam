import XCTest
@testable import Services

class ChartXAxisDateFormatterTest: XCTestCase {

    private let expectedResult = [
        20: "0 h",
        60: "1 h",
        200: "3 h"
    ]

    func test() {
        expectedResult.forEach {
            let hours = TimeFormatter.minutesToHours($0.key)
            XCTAssertEqual(hours, $0.value)
        }
    }

}
