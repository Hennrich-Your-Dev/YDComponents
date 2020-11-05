//
//  UIImageExtension.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 22/10/20.
//

import UIKit

extension UIImage {
  struct Icon {
    static var thumbsUp: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsSocialThumbUp", in: bundle, compatibleWith: nil)
    }

    static var thumbsUpRed: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsSocialThumbUpRed", in: bundle, compatibleWith: nil)
    }

    static var thumbsDown: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsSocialThumbDown", in: bundle, compatibleWith: nil)
    }

    static var reload: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsNavigationReload", in: bundle, compatibleWith: nil)
    }

    static var defaultUser: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsCircleDefault", in: bundle, compatibleWith: nil)
    }

    static var defaultUserOff: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsCircleDefaultOff", in: bundle, compatibleWith: nil)
    }

    static var americanas: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsCircleAcom", in: bundle, compatibleWith: nil)
    }

    static var send: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsChatSend", in: bundle, compatibleWith: nil)
    }

    static var userRed: UIImage? {
      let bundle = Bundle.init(for: YDMessageField.self)
      return UIImage(named: "iconsActionUser", in: bundle, compatibleWith: nil)
    }
  }
}
