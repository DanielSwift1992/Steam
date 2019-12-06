public final class PlayerStatValueFormatter { }

// MARK: - Methods

public extension PlayerStatValueFormatter {

    static func convert(_ value: Double) -> String {
        value > 1000 ? value.shorted : value.removedTrailingZero
    }

}
