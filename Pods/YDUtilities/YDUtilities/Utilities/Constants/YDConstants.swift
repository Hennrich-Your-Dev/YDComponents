//
//  YDConstants.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 16/06/21.
//

import UIKit

public enum YDConstants {
  // Notifications
  public struct Notification {
    // Spacey
    public static let SpaceyNPSChangeValue = NSNotification.Name("YDSpaceyNPSChangeValue")
    public static let SpaceyErrorTrigger = NSNotification.Name("YDSpaceyErrorTrigger")
    public static let SpaceyProductAddToCard = NSNotification.Name("YDSpaceyProductAddToCard")

    // Components
    public static let ComponentsCleanUpReply = NSNotification.Name("YDComponentsCleanUpReply")
    public static let ComponentsMessageFieldResign = NSNotification.Name("YDMessageFieldResignFirstResponder")

    // Miscellaneous
    public static let Deinit = NSNotification.Name("YDDeinit")
  }

  // UserDefaults
  public struct UserDefaults {
    public static let savedNextLives = "YDSavedNextLives"
    public static let savedLiveNPS = "YDSavedLiveNPS"
  }

  // Screen
  public struct Screen {
    public static let width = UIScreen.main.bounds.size.width
    public static let height = UIScreen.main.bounds.size.height
    public static let maxLength = max(YDConstants.Screen.width, YDConstants.Screen.height)
    public static let minLength = min(YDConstants.Screen.width, YDConstants.Screen.height)
  }

  // Device Types
  public struct DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isiPhoneSE = idiom == .phone && YDConstants.Screen.maxLength == 568.0
    static let isiPhone8Standard = idiom == .phone && YDConstants.Screen.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && YDConstants.Screen.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard = idiom == .phone && YDConstants.Screen.maxLength == 736.0
    static let isiPhone8PlusZoomed = idiom == .phone && YDConstants.Screen.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX = idiom == .phone && YDConstants.Screen.maxLength == 812.0
    static let isiPhoneXsMaxAndXr = idiom == .phone && YDConstants.Screen.maxLength == 896.0
    static let isiPad = idiom == .pad && YDConstants.Screen.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
      return isiPhoneX || isiPhoneXsMaxAndXr
    }
  }
}
