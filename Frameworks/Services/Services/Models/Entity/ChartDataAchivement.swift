public struct ChartDataModel<T: Equatable>: Equatable {
    public var x: Double
    public var y: Double
    public let data: T
}
