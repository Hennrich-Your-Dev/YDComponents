//
//  UIAlertControllerExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//
import UIKit

extension UIAlertController {

  public func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
      let alertWindow = UIWindow(frame: UIScreen.main.bounds)
      alertWindow.rootViewController = UIViewController()
      alertWindow.windowLevel = UIWindow.Level.alert + 1
      alertWindow.makeKeyAndVisible()
      alertWindow.rootViewController?.present(self,
                                              animated: animated,
                                              completion: completion)
  }

  public class func showAlert(
    title: String = "Alerta",
    message: String
  ) {

    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alertController.addAction(UIAlertAction(title: "OK",
                                            style: UIAlertAction.Style.cancel,
                                            handler: nil))

    alertController.presentInOwnWindow(animated: true, completion: nil)
  }
}
