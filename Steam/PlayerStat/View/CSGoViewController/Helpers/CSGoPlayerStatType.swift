import UIKit

extension CSGoPlayerStat.StatType {

    var text: String {
        typealias Title = L10n.LocalStat.CSGo.StatType

        switch self {
        case .accuracyRate: return Title.accuracyRate
        case .headshotsRate: return Title.headshotsRate
        case .killDeathRate: return Title.killDeathRate
        case .killes: return Title.killes
        case .mvp: return Title.mvp
        case .timePlayed: return Title.timePlayed
        case .winRate: return Title.winRate
        }
    }

    var icon: UIImage? {
        typealias Icon = CommonAsset.CSGo

        switch self {
        case .accuracyRate: return Icon.aim.image
        case .headshotsRate: return Icon.headshot.image
        case .killes: return Icon.shot.image
        case .mvp: return Icon.mvp.image
        case .timePlayed: return Icon.time.image
        case .winRate: return Icon.victory.image
        case .killDeathRate: return .init()
        }
    }

}
