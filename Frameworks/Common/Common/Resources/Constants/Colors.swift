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
  public static let chartColor = ColorName(rgbaValue: 0x5f1832ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f30040"></span>
  /// Alpha: 100% <br/> (0xf30040ff)
  public static let mainAccent = ColorName(rgbaValue: 0xf30040ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#151b27"></span>
  /// Alpha: 100% <br/> (0x151b27ff)
  public static let mainBackgroundDark = ColorName(rgbaValue: 0x151b27ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e7e7e7"></span>
  /// Alpha: 100% <br/> (0xe7e7e7ff)
  public static let mainBackgroundLight = ColorName(rgbaValue: 0xe7e7e7ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ca0070"></span>
  /// Alpha: 100% <br/> (0xca0070ff)
  public static let subAccent = ColorName(rgbaValue: 0xca0070ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#111b2a"></span>
  /// Alpha: 100% <br/> (0x111b2aff)
  public static let subBackground1Dark = ColorName(rgbaValue: 0x111b2aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c9c9c9"></span>
  /// Alpha: 100% <br/> (0xc9c9c9ff)
  public static let subBackground1Light = ColorName(rgbaValue: 0xc9c9c9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#141c29"></span>
  /// Alpha: 100% <br/> (0x141c29ff)
  public static let subBackground2Dark = ColorName(rgbaValue: 0x141c29ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dadadb"></span>
  /// Alpha: 100% <br/> (0xdadadbff)
  public static let subBackground2Light = ColorName(rgbaValue: 0xdadadbff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9d9ea2"></span>
  /// Alpha: 100% <br/> (0x9d9ea2ff)
  public static let subTextDark = ColorName(rgbaValue: 0x9d9ea2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#5c606c"></span>
  /// Alpha: 100% <br/> (0x5c606cff)
  public static let subTextLight = ColorName(rgbaValue: 0x5c606cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#edecee"></span>
  /// Alpha: 100% <br/> (0xedeceeff)
  public static let textTitle = ColorName(rgbaValue: 0xedeceeff)
}
// swiftlint:enable identifier_name line_length type_body_length

public extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
