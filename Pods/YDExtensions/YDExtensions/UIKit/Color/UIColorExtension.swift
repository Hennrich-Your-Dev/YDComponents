//
//  UIColorExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//

import UIKit

public extension UIColor {
  static let customRed = UIColor(red: 230/255, green: 0/255, blue: 20/255, alpha: 1)
}

// MARK: Zeplin
public extension UIColor {

  struct Zeplin {
    public static var black: UIColor {
      return UIColor(white: 51.0 / 255.0, alpha: 1.0)
    }

    public static var white: UIColor {
      return UIColor(white: 1.0, alpha: 1.0)
    }

    // MARK: Red
    public static var colorPrimaryLight: UIColor {
      return UIColor(red: 252.0 / 255.0, green: 13.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }

    public static var colorPrimaryLightDisabled: UIColor {
      return UIColor(red: 243.0 / 255.0, green: 128.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
    }

    public static var redBranding: UIColor {
      return UIColor(red: 230.0 / 255.0, green: 0.0, blue: 20.0 / 255.0, alpha: 1.0)
    }

    public static var redDark: UIColor {
      return UIColor(red: 171.0 / 255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }

    public static var redOpaque: UIColor {
      return UIColor(red: 1.0, green: 235.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }

    public static var redNight: UIColor {
      return UIColor(red: 1.0, green: 69.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
    }

    // MARK: Green
    public static var greenLight: UIColor {
      return UIColor(red: 153.0 / 255.0, green: 224.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }

    public static var greenNight: UIColor {
      return UIColor(red: 50.0 / 255.0, green: 215.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
    }

    public static var greenDone: UIColor {
      return UIColor(red: 102.0 / 255.0, green: 206.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }

    public static var greenOpaque: UIColor {
      return UIColor(red: 220.0 / 255.0, green: 237.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
    }

    public static var greenDark: UIColor {
      return UIColor(red: 0.0, green: 177.0 / 255.0, blue: 1.0 / 255.0, alpha: 1.0)
    }

    // MARK: Yellow
    public static var yellowBranding: UIColor {
      return UIColor(red: 250.0 / 255.0, green: 215.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    }

    public static var yellowDark: UIColor {
      return UIColor(red: 229.0 / 255.0, green: 157.0 / 255.0, blue: 14.0 / 255.0, alpha: 1.0)
    }

    public static var yellowLight: UIColor {
      return UIColor(red: 1.0, green: 240.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }

    public static var yellowNight: UIColor {
      return UIColor(red: 1.0, green: 214.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    }

    public static var yellowOpaque: UIColor {
      return UIColor(red: 1.0, green: 244.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    }

    // MARK: Blue
    public static var blueDark: UIColor {
      return UIColor(red: 25.0 / 255.0, green: 160.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
    }

    public static var blueLight: UIColor {
      return UIColor(red: 36.0 / 255.0, green: 203.0 / 255.0, blue: 1.0, alpha: 1.0)
    }

    public static var blueNight: UIColor {
      return UIColor(red: 100.0 / 255.0, green: 210.0 / 255.0, blue: 1.0, alpha: 1.0)
    }

    public static var blueOpaque: UIColor {
      return UIColor(red: 225.0 / 255.0, green: 245.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
    }

    // MARK: Gray
    public static var grayDisabled: UIColor {
      return UIColor(white: 232.0 / 255.0, alpha: 1.0)
    }

    public static var grayLight: UIColor {
      return UIColor(white: 136.0 / 255.0, alpha: 1.0)
    }

    public static var grayNight: UIColor {
      return UIColor(white: 204.0 / 255.0, alpha: 1.0)
    }

    public static var grayOpaque: UIColor {
      return UIColor(white: 241.0 / 255.0, alpha: 1.0)
    }

    public static var graySurface: UIColor {
      return UIColor(white: 248.0 / 255.0, alpha: 1.0)
    }
  }
}

// MARK: Hex
// how to use:
// let white = UIColor(hex: "#ffffff")
public extension UIColor {
  convenience init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0

    let length = hexSanitized.count

    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

    if length == 6 {
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      b = CGFloat(rgb & 0x0000FF) / 255.0

    } else if length == 8 {
      r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(rgb & 0x000000FF) / 255.0

    } else {
      return nil
    }

    self.init(red: r, green: g, blue: b, alpha: a)
  }
}
