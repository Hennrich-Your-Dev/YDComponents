//
//  UIDeviceExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 23/10/20.
//

import UIKit

extension UIDevice {

  var hasNotch: Bool {
    if #available(iOS 11.0, *) {
      return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 > 0
    }
    return false
  }
}
