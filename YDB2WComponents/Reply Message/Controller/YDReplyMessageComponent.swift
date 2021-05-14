//
//  YDReplyMessageComponent.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 13/05/21.
//

import UIKit

public class YDReplyMessageComponent: UIView {
  // MARK: Enum
  public enum Stage {
    case typing
    case replied
  }

  // MARK: Properties
  public var stage: Stage = .typing {
    didSet {
      changeUIState(with: stage)
    }
  }
  public var callback: (() -> Void)?

  // MARK: Components
  let container = UIView()
  lazy var leadingContainerConstraint: NSLayoutConstraint = {
    return container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
  }()

  let leftView = UIView()
  let usernameLabel = UILabel()
  let messageLabel = UILabel()
  lazy var trailingMessageConstraint: NSLayoutConstraint = {
    return messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60)
  }()

  let actionButton = UIButton()
  let arrowIcon = UIImageView()

  // MARK: Init
  public init() {
    super.init(frame: .zero)

    configureLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Actions
  public func configure() {
    usernameLabel.text = "Marcela"
    messageLabel.text = .loremIpsum()
  }

  @objc func onActionButton() {
    callback?()
  }

  func changeUIState(with stage: Stage) {
    stage == .typing ? changeToTyping() : changeToReplied()
  }

  func changeToTyping() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      self.leadingContainerConstraint.constant = 0
      self.trailingMessageConstraint.constant = -60
      self.leftView.layer.cornerRadius = 0
      self.arrowIcon.isHidden = true
      self.actionButton.isHidden = false
    }
  }

  func changeToReplied() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      self.leadingContainerConstraint.constant = 44
      self.trailingMessageConstraint.constant = -6
      self.leftView.layer.maskedCorners = [.layerMinXMinYCorner]
      self.leftView.layer.cornerRadius = 8
      self.arrowIcon.isHidden = false
      self.actionButton.isHidden = true
    }
  }
}
