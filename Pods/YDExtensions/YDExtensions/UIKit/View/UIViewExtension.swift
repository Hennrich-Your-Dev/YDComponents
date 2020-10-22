//
//  UIViewExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//
// swiftlint:disable force_unwrapping force_cast
import UIKit

extension UIView {

  public class var identifier: String {
    return String(describing: self)
  }

  public func loadNib() -> UIView {
    let bundle = Bundle.init(for: type(of: self))
    let nibName = Self.description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as! UIView
  }

  public class func loadFromNibNamed(
    _ nibNamed: String,
    _ bundle: Bundle? = Bundle.main
  ) -> UINib {
    return UINib(nibName: nibNamed, bundle: bundle)
  }

  public class func loadNib(_ bundle: Bundle? = Bundle.main) -> UINib {
    return loadFromNibNamed(self.identifier, bundle)
  }

  public class func loadFromNib(bundle: Bundle? = Bundle.main) -> UIView? {
    return loadFromNibNamed(self.identifier, bundle).instantiate(
      withOwner: nil,
      options: nil
      )[0] as? UIView
  }
}

extension UIView {

  // MARK: Loading
  public func startLoader(message: String? = nil) {
    let viewLoading = UIView(frame: self.frame)
    viewLoading.tag = 99999
    viewLoading.backgroundColor = .white
    viewLoading.center = self.center

    // Activity Indicator
    let loader = UIActivityIndicatorView(style: .whiteLarge)
    loader.startAnimating()
    loader.center = viewLoading.center
    loader.color = UIColor.customRed
    viewLoading.addSubview(loader)

    self.addSubview(viewLoading)
    self.bringSubviewToFront(viewLoading)
  }

  public func stopLoader() {
    self.subviews.forEach { view in
      if view.tag == 99999 {
        view.removeFromSuperview()
      }
    }
  }
}
