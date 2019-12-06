public extension BinaryFloatingPoint {

    func rounded(to places: Int) -> Self {
        let divisor = pow(10.0, Double(Self(places)))
        return Self((Double(self) * divisor).rounded() / divisor)
    }

    var shorted: String { Int(self).shorted }

    var removedTrailingZero: String {
        let value = Double(self)
        let format = value.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.2f"
        return String(format: format, value)
    }

}
