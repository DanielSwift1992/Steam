final public class AchivementFormatter { }

// MARK: Methods

extension AchivementFormatter {

    func convert(achivements: [Achivement],
                 by component: Calendar.Component) -> [ChartDataModel<Date>] {

        achivements.sorted(by: \.date)
            .reduce(into: [ChartDataModel<Date>]()) {
                reduce(into: &$0, item: $1, by: component)
        }
    }

}

// MARK: Private Methods

private extension AchivementFormatter {

    func reduce(into chartModels: inout [ChartDataModel<Date>],
                item: Achivement,
                by component: Calendar.Component) {

        guard let model = chartModels.last else {
            chartModels.append(.init(x: 1, y: 1, data: item.date))
            return
        }

        let order = Calendar.current.compare(model.data,
                                             to: item.date,
                                             toGranularity: component)

        order == .orderedSame
            ? incrementLast(in: &chartModels)
            : calculateXAndAppend(model: model,
                                  item: item,
                                  by: component,
                                  in: &chartModels)
    }

    func incrementLast(in chartModels: inout [ChartDataModel<Date>]) {
        var lastModel = chartModels.removeLast()
        lastModel.y += 1
        chartModels.append(lastModel)
    }

    func calculateXAndAppend(model: ChartDataModel<Date>,
                             item: Achivement,
                             by component: Calendar.Component,
                             in chartModels: inout [ChartDataModel<Date>]) {
        let components = Calendar.current.dateComponents([component],
                                                         from: model.data,
                                                         to: item.date)

        let xDelta = components.value(for: component) ?? 0
        let xDeltaAdjusted = Double(max(xDelta, 1))
        chartModels.append(.init(x: model.x + xDeltaAdjusted, y: 1, data: item.date))
    }

}
