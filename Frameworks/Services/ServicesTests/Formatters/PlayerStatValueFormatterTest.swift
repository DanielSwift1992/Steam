import XCTest
@testable import Services

class PlayerStatValueFormatterTest: XCTestCase {

    private let expectedResult = [
        0.0: "0",
        1.1: "1.10",
        1_001: "1K",
        1_000_00: "100.0k",
        1_100_000: "1.1M"
    ]

    func test() {
        expectedResult.forEach {
            let value = PlayerStatValueFormatter.convert($0.key)
            XCTAssertEqual(value, $0.value)
        }
    }

}
