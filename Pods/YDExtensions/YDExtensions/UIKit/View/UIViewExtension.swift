//
//  UIViewExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//
// swiftlint:disable force_unwrapping force_cast
import UIKit

public extension UIView {

  class var identifier: String {
    return String(describing: self)
  }

  func loadNib() -> UIView {
    let bundle = Bundle.init(for: type(of: self))
    let nibName = Self.description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as! UIView
  }

  class func loadFromNibNamed(
    _ nibNamed: String,
    _ bundle: Bundle? = Bundle.main
  ) -> UINib {
    return UINib(nibName: nibNamed, bundle: bundle)
  }

  class func loadNib(_ bundle: Bundle? = Bundle.main) -> UINib {
    return loadFromNibNamed(self.identifier, bundle)
  }

  class func loadFromNib(bundle: Bundle? = Bundle.main) -> UIView? {
    return loadFromNibNamed(self.identifier, bundle).instantiate(
      withOwner: nil,
      options: nil
      )[0] as? UIView
  }
}

public extension UIView {

  // MARK: Loading
  func startLoader(message: String? = nil) {
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

  func stopLoader() {
    self.subviews.forEach { view in
      if view.tag == 99999 {
        view.removeFromSuperview()
      }
    }
  }

  // MARK: Corner round
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}
