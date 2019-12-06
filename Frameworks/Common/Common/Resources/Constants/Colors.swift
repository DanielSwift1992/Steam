// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  public typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  public typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
public extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
public struct ColorName {
  public let rgbaValue: UInt32
  public var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#5f1832"></span>
  /// Alpha: 100% <br/> (0x5f1832ff)
  public static let chartColorDark = ColorName(rgbaValue: 0x5f1832ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e48ba0"></span>
  /// Alpha: 100% <br/> (0xe48ba0ff)
  public static let chartColorLight = ColorName(rgbaValue: 0xe48ba0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f30040"></span>
  /// Alpha: 100% <br/> (0xf30040ff)
  public static let mainAccent = ColorName(rgbaValue: 0xf30040ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f30040"></span>
  /// Alpha: 100% <br/> (0xf30040ff)
  public static let mainAccentShadowDark = ColorName(rgbaValue: 0xf30040ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d2d2d2"></span>
  /// Alpha: 100% <br/> (0xd2d2d2ff)
  public static let mainAccentShadowLight = ColorName(rgbaValue: 0xd2d2d2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#151b27"></span>
  /// Alpha: 100% <br/> (0x151b27ff)
  public static let mainBackgroundDark = ColorName(rgbaValue: 0x151b27ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d2d2d2"></span>
  /// Alpha: 100% <br/> (0xd2d2d2ff)
  public static let mainBackgroundLight = ColorName(rgbaValue: 0xd2d2d2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ca0070"></span>
  /// Alpha: 100% <br/> (0xca0070ff)
  public static let subAccent = ColorName(rgbaValue: 0xca0070ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#101b2b"></span>
  /// Alpha: 100% <br/> (0x101b2bff)
  public static let subBackground1Dark = ColorName(rgbaValue: 0x101b2bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cbcccd"></span>
  /// Alpha: 100% <br/> (0xcbcccdff)
  public static let subBackground1Light = ColorName(rgbaValue: 0xcbcccdff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#131a27"></span>
  /// Alpha: 100% <br/> (0x131a27ff)
  public static let subBackground2Dark = ColorName(rgbaValue: 0x131a27ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cfcfcf"></span>
  /// Alpha: 100% <br/> (0xcfcfcfff)
  public static let subBackground2Light = ColorName(rgbaValue: 0xcfcfcfff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9d9ea2"></span>
  /// Alpha: 100% <br/> (0x9d9ea2ff)
  public static let subTextDark = ColorName(rgbaValue: 0x9d9ea2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#5c606c"></span>
  /// Alpha: 100% <br/> (0x5c606cff)
  public static let subTextLight = ColorName(rgbaValue: 0x5c606cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#edecee"></span>
  /// Alpha: 100% <br/> (0xedeceeff)
  public static let textTitleDark = ColorName(rgbaValue: 0xedeceeff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#090303"></span>
  /// Alpha: 100% <br/> (0x090303ff)
  public static let textTitleLight = ColorName(rgbaValue: 0x090303ff)
}
// swiftlint:enable identifier_name line_length type_body_length

public extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
