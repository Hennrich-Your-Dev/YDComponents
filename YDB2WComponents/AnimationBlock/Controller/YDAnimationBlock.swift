//
//  YDAnimationBlock.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 17/11/20.
//

import UIKit
import YDExtensions

class YDAnimationBlock: UIView {
  // MARK: Properties
  var currentIcon: UIImage? = UIImage.Icon.thumbsUpRed
  var columns: [CGFloat] = []

  // MARK: Init
  public init() {
    let rect = CGRect(x: 0, y: 0, width: 60, height: 420)
    super.init(frame: rect)
    instanceXib()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    instanceXib()
  }

  // MARK: IBOutlets
  @IBOutlet var contentView: UIView!

  // MARK: Actions
  private func instanceXib() {
    contentView = loadNib()
    addSubview(contentView)

    contentView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: self.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }

  private func calculateColumns() {
    let width = contentView.frame.width
    let half = width / 2
    let divided = width / 4

    columns.append(half - (2 * divided))
    columns.append(half - divided)
    columns.append(half + divided)
    columns.append(half + (2 * divided))
    print(columns)
  }
  
}
