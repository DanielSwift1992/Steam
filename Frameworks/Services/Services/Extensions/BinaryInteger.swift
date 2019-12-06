public extension BinaryInteger {

    var shorted: String {
        let value: Double = Double(self)

        if value >= 1000 && value < 10000 {
            return String(format: "%.1fK", Double(value/100)/10)
                .replacingOccurrences(of: ".0", with: "")
        }

        if value >= 10000 && value < 1000000 {
            return "\(value/1000)k"
        }

        if value >= 1000000 && value < 10000000 {
            return String(format: "%.1fM", Double(value/100000)/10).replacingOccurrences(of: ".0", with: "")
        }

        if value >= 10000000 {
            return "\(value/1000000)M"
        }

        return String(value)
    }

}
