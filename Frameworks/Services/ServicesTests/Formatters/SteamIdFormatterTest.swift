import XCTest
@testable import Services

class SteamIdFormatterTest: XCTestCase {

    private let wrongUrls = [
        "",
        "profiles",
        ".profiles.id",
        "https://hh.co",
        "https://profiles.id",
        "https://www.h/profile/",
        "https://www.h/id/"
    ]

    private let expectedResult = [
        "https://www.h/id/2" : SteamID.vanityID("2"),
        "https://www.h/profiles/2" : SteamID.id64("2"),
    ]

    func testWrongURls() {
        let ids = wrongUrls
            .compactMap { URL(string: $0) }
            .compactMap { SteamIdFormatter.convert(url: $0) }

        XCTAssertTrue(ids.isEmpty)
    }

    func testExpectedResult() {
        expectedResult.forEach {
            let value = SteamIdFormatter.convert(url: URL(string: $0.key)!)
            XCTAssertEqual($0.value, value)
        }
    }

}
