//
//  YDAnimationBlock.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 17/11/20.
//

import UIKit
import YDExtensions

public class YDAnimationBlock: UIView {
  // MARK: Properties
  var icons: [UIImage?] = []
  let sizes: [CGFloat] = [24, 20, 18, 12]
  var columns: [CGFloat] = [-10, 10, 20, 30, 40, 50]

  // MARK: Init
  public init() {
    let rect = CGRect(x: 0, y: 0, width: 60, height: 420)
    super.init(frame: rect)
    backgroundColor = .clear
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    backgroundColor = .clear
  }

  public func config(iconsToSort: [UIImage?]) {
    self.icons = iconsToSort
  }

  public func addIcon() {
    let size = sizes.randomElement() ?? 0
    let x = columns.randomElement() ?? 0
    let futureX = columns.randomElement() ?? 0
    let iconImage = icons.randomElement() ?? nil

    let icon = UIImageView(image: iconImage)
    icon.frame = CGRect(x: x, y: frame.height, width: size, height: size)
    addSubview(icon)

    UIView.animate(withDuration: 3) {
      icon.frame = CGRect(
        x: futureX,
        y: -50,
        width: icon.frame.width,
        height: icon.frame.height
      )
      icon.alpha = 0
    } completion: { _ in
      icon.removeFromSuperview()
    }
  }
}
