import UIKit

public enum Theme { }

public extension Theme {

    static var textTitle: UIColor {
        ColorName.textTitle.color
    }

    static var subText: UIColor {
        fromStyle(any: .subTextLight, dark: .subTextDark)
    }

    static var mainAccent: UIColor {
        ColorName.mainAccent.color
    }

    static var subAccent: UIColor {
        ColorName.subAccent.color
    }

    static var mainBackground: UIColor {
        fromStyle(any: .mainBackgroundLight, dark: .mainBackgroundDark)
    }

    static var subBackground1: UIColor {
        fromStyle(any: .subBackground1Light, dark: .subBackground1Dark)
    }

    static var subBackground2: UIColor {
        fromStyle(any: .subBackground2Light, dark: .subBackground2Dark)
    }

    static var chartColor: UIColor {
        ColorName.chartColor.color
    }

}

private extension Theme {

    static func fromStyle(any: ColorName, dark: ColorName) -> UIColor {
        if #available(iOS 13.0, *) {
            return .init { $0.userInterfaceStyle == .dark ? dark.color : any.color }
        } else {
            return any.color
        }
    }

}
