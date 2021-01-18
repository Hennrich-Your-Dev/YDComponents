//
//  YDSnackBarView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit

import YDExtensions

public protocol YDSnackBarDelegate: AnyObject {
  func onSnackAction()
}

// MARK: Enum
public enum YDSnackBarType {
  case withButton(buttonName: String)
  case simple
}

public class YDSnackBarView: UIView {
  // MARK: Properties
  public weak var delegate: YDSnackBarDelegate?
  var parent: UIView

  // MARK: Life cycle
  public init(parent: UIView) {
    self.parent = parent
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Actions
  public func showMessage(
    _ message: String,
    ofType type: YDSnackBarType,
    withIcon icon: UIImage? = nil
  ) {
    switch type {
      case .simple:
        buildSimpleLayout(message: message, icon: icon)

      case .withButton(let buttonName):
        buildWithButtonLayout(message: message, buttonName: buttonName, icon: icon)
    }
  }

  private func buildSimpleLayout(message: String, icon: UIImage?) {
    let width = parent.frame.size.width / 1.5
    let rect = CGRect(
      x: (parent.frame.size.width - width) / 2,
      y: parent.frame.size.height,
      width: width,
      height: 46
    )
    frame = rect
    layer.zPosition = CGFloat.greatestFiniteMagnitude
    backgroundColor = UIColor.Zeplin.black
    layer.cornerRadius = 8

    parent.addSubview(self)

    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0).isActive = true
    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 12).isActive = true
    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 12).isActive = true

    let label = createLabel(message)
    addSubview(label)

    label.bindFrame(top: 16, bottom: 16, leading: 21, trailing: 21, toView: self)

    UIView.animate(withDuration: 0.5) {
      self.bottomAnchor.constraint(equalTo: self.parent.safeAreaLayoutGuide.bottomAnchor, constant: 40).isActive = true
      self.parent.layoutIfNeeded()
      //
    } completion: { done in
      if done {
        UIView.animate(withDuration: 0.5, delay: 5) {
          self.bottomAnchor.constraint(equalTo: self.parent.bottomAnchor, constant: 0).isActive = true
          self.parent.layoutIfNeeded()
        } completion: { _ in
          self.removeFromSuperview()
        }
      }
    }
  }

  private func buildWithButtonLayout(message: String, buttonName: String, icon: UIImage?) {
    //
  }

  private func createLabel(_ message: String) -> UILabel {
    let label = UILabel()
    label.text = message
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = UIColor.Zeplin.grayNight
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }
}
