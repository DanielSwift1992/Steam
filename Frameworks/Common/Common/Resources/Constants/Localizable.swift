// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
public enum L10n {

  public enum Authorization {

    public enum BarButton {
      /// cancel
      public static let cancel = L10n.tr("Localizable", "Authorization.BarButton.cancel")
    }
  }

  public enum Friends {
    /// Friends
    public static let title = L10n.tr("Localizable", "Friends.title")
  }

  public enum GameSession {
    /// Played for 2 weeks
    public static let title = L10n.tr("Localizable", "GameSession.title")
  }

  public enum LocalStat {
    /// Detail Statistic
    public static let title = L10n.tr("Localizable", "LocalStat.title")

    public enum CSGo {
      /// CS GO
      public static let title = L10n.tr("Localizable", "LocalStat.CSGo.title")

      public enum StatType {
        /// ACCURACY
        public static let accuracyRate = L10n.tr("Localizable", "LocalStat.CSGo.StatType.accuracyRate")
        /// HEADSHOT
        public static let headshotsRate = L10n.tr("Localizable", "LocalStat.CSGo.StatType.headshotsRate")
        /// K/D RATIO
        public static let killDeathRate = L10n.tr("Localizable", "LocalStat.CSGo.StatType.killDeathRate")
        /// KILLS
        public static let killes = L10n.tr("Localizable", "LocalStat.CSGo.StatType.killes")
        /// MVPs
        public static let mvp = L10n.tr("Localizable", "LocalStat.CSGo.StatType.mvp")
        /// TIME PLAYED
        public static let timePlayed = L10n.tr("Localizable", "LocalStat.CSGo.StatType.timePlayed")
        /// WIN %
        public static let winRate = L10n.tr("Localizable", "LocalStat.CSGo.StatType.winRate")
      }
    }
  }

  public enum Login {
    /// Welcome
    public static let greatings = L10n.tr("Localizable", "Login.greatings")
    /// Hello,\n%@
    public static func greatingsUser(_ p1: String) -> String {
      return L10n.tr("Localizable", "Login.greatingsUser", p1)
    }

    public enum Button {
      /// As another user
      public static let anotherUser = L10n.tr("Localizable", "Login.button.anotherUser")
      /// Login
      public static let login = L10n.tr("Localizable", "Login.button.login")
    }
  }

  public enum Profile {
    /// %d level
    public static func level(_ p1: Int) -> String {
      return L10n.tr("Localizable", "Profile.Level", p1)
    }
    /// Profile
    public static let title = L10n.tr("Localizable", "Profile.title")

    public enum HeaderView {
      /// Friends
      public static let friends = L10n.tr("Localizable", "Profile.HeaderView.friends")
      /// Statistic
      public static let statistic = L10n.tr("Localizable", "Profile.HeaderView.statistic")
    }
  }

  public enum Statistics {
    /// Statistics
    public static let title = L10n.tr("Localizable", "Statistics.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

public extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
