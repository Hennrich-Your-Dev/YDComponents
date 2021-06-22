//
//  YDCountDownComponentView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 09/06/21.
//

import UIKit
import YDExtensions

class YDCountDownComponentView: UIView {
  // MARK: Enum
  enum NumberType {
    case left
    case left2
    case right
    case right2
  }

  // MARK: Properties
  var currentLeft: NumberType = .left
  var currentRight: NumberType = .right

  // MARK: Components
  let leftNumberView = UIView()
  let leftNumberLabel = UILabel()
  lazy var leftNumberCenterYConstraint: NSLayoutConstraint = {
    leftNumberLabel.centerYAnchor.constraint(equalTo: leftNumberView.centerYAnchor)
  }()
  let leftNumberLabel2 = UILabel()
  lazy var leftNumber2CenterYConstraint: NSLayoutConstraint = {
    leftNumberLabel2.centerYAnchor.constraint(equalTo: leftNumberView.centerYAnchor)
  }()

  let rightNumberView = UIView()
  let rightNumberLabel = UILabel()
  lazy var rightNumberCenterYConstraint: NSLayoutConstraint = {
    rightNumberLabel.centerYAnchor.constraint(equalTo: rightNumberView.centerYAnchor)
  }()
  let rightNumberLabel2 = UILabel()
  lazy var rightNumber2CenterYConstraint: NSLayoutConstraint = {
    rightNumberLabel2.centerYAnchor.constraint(equalTo: rightNumberView.centerYAnchor)
  }()

  let descriptionLabel = UILabel()

  // MARK: Init
  init(description: String) {
    super.init(frame: .zero)
    configureUI()
    descriptionLabel.text = description
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Actions
  func update(left: String?, right: String?) {
    if let nextNumber = left {
      animateLeftLabel(nextNumber: nextNumber)
    }

    if let nextNumber = right {
      animateRightLabel(nextNumber: nextNumber)
    }
  }

  func animateLeftLabel(nextNumber: String) {
    if currentLeft == .left {
      currentLeft = .left2
      leftNumberCenterYConstraint.constant = -50
      leftNumberLabel2.text = nextNumber

      UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      } completion: { [weak self] _ in
        guard let self = self else { return }
        self.leftNumberCenterYConstraint.constant = 0
        self.layoutIfNeeded()
      }

      leftNumber2CenterYConstraint.constant = 0
      UIView.animate(withDuration: 0.5) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      }

      //
    } else {
      currentLeft = .left
      leftNumber2CenterYConstraint.constant = -50
      leftNumberLabel.text = nextNumber
      UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      } completion: { [weak self] _ in
        guard let self = self else { return }
        self.leftNumberCenterYConstraint.constant = 0
        self.layoutIfNeeded()
      }

      leftNumberCenterYConstraint.constant = 0
      UIView.animate(withDuration: 0.5) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      }
    }
  }

  func animateRightLabel(nextNumber: String) {
    if currentRight == .right {
      currentRight = .right2
      rightNumberCenterYConstraint.constant = -50
      rightNumberLabel2.text = nextNumber

      UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      } completion: { [weak self] _ in
        guard let self = self else { return }
        self.rightNumberCenterYConstraint.constant = 0
        self.layoutIfNeeded()
      }

      rightNumber2CenterYConstraint.constant = 0
      UIView.animate(withDuration: 0.5) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      }

      //
    } else {
      currentLeft = .right
      rightNumber2CenterYConstraint.constant = -50
      rightNumberLabel.text = nextNumber
      UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      } completion: { [weak self] _ in
        guard let self = self else { return }
        self.rightNumberCenterYConstraint.constant = 0
        self.layoutIfNeeded()
      }

      rightNumberCenterYConstraint.constant = 0
      UIView.animate(withDuration: 0.5) { [weak self] in
        guard let self = self else { return }
        self.layoutIfNeeded()
      }
    }
  }
}

// MARK: UI
extension YDCountDownComponentView {
  func configureUI() {
    let views = [
      leftNumberView,
      rightNumberView,
      descriptionLabel
    ]

    views.forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    configureLeftView()
    configureRightView()
    configureDescriptionLabel()
  }

  func configureLeftView() {
    leftNumberView.backgroundColor = Zeplin.redPale
    leftNumberView.layer.cornerRadius = 2

    NSLayoutConstraint.activate([
      leftNumberView.topAnchor.constraint(equalTo: topAnchor),
      leftNumberView.leadingAnchor.constraint(equalTo: leadingAnchor),
      leftNumberView.widthAnchor.constraint(equalToConstant: 24),
      leftNumberView.heightAnchor.constraint(equalToConstant: 34)
    ])

    // Number Label
    leftNumberView.addSubview(leftNumberLabel)
    leftNumberLabel.font = .boldSystemFont(ofSize: 20)
    leftNumberLabel.textColor = Zeplin.redNight
    leftNumberLabel.textAlignment = .center
    leftNumberLabel.text = "0"

    leftNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    leftNumberCenterYConstraint.isActive = true
    leftNumberLabel.centerXAnchor
      .constraint(equalTo: leftNumberView.centerXAnchor).isActive = true

    // Number Label 2
    leftNumberView.addSubview(leftNumberLabel2)
    leftNumberLabel2.font = .boldSystemFont(ofSize: 20)
    leftNumberLabel2.textColor = Zeplin.redNight
    leftNumberLabel2.textAlignment = .center
    leftNumberLabel2.text = "0"

    leftNumberLabel2.translatesAutoresizingMaskIntoConstraints = false
    leftNumber2CenterYConstraint.isActive = true
    leftNumber2CenterYConstraint.constant = 45
    leftNumberLabel2.centerXAnchor
      .constraint(equalTo: leftNumberView.centerXAnchor).isActive = true
  }

  func configureRightView() {
    rightNumberView.backgroundColor = Zeplin.redPale
    rightNumberView.layer.cornerRadius = 2

    NSLayoutConstraint.activate([
      rightNumberView.topAnchor.constraint(equalTo: topAnchor),
      rightNumberView.leadingAnchor
        .constraint(equalTo: leftNumberView.trailingAnchor, constant: 2),
      rightNumberView.trailingAnchor.constraint(equalTo: trailingAnchor),
      rightNumberView.widthAnchor.constraint(equalToConstant: 24),
      rightNumberView.heightAnchor.constraint(equalToConstant: 34)
    ])

    // Number Label
    rightNumberView.addSubview(rightNumberLabel)
    rightNumberLabel.font = .boldSystemFont(ofSize: 20)
    rightNumberLabel.textColor = Zeplin.redNight
    rightNumberLabel.textAlignment = .center
    rightNumberLabel.text = "0"

    rightNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    rightNumberCenterYConstraint.isActive = true
    rightNumberLabel.centerXAnchor
      .constraint(equalTo: rightNumberView.centerXAnchor).isActive = true

    // Number Label 2
    rightNumberView.addSubview(rightNumberLabel2)
    rightNumberLabel2.font = .boldSystemFont(ofSize: 20)
    rightNumberLabel2.textColor = Zeplin.redNight
    rightNumberLabel2.textAlignment = .center
    rightNumberLabel2.text = "0"

    rightNumberLabel2.translatesAutoresizingMaskIntoConstraints = false
    rightNumber2CenterYConstraint.isActive = true
    rightNumber2CenterYConstraint.constant = 45
    rightNumberLabel2.centerXAnchor
      .constraint(equalTo: rightNumberView.centerXAnchor).isActive = true
  }

  func configureDescriptionLabel() {
    descriptionLabel.textColor = Zeplin.grayLight
    descriptionLabel.textAlignment = .center
    descriptionLabel.font = .systemFont(ofSize: 10, weight: .medium)

    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: leftNumberView.bottomAnchor, constant: 6),
      descriptionLabel.leadingAnchor.constraint(equalTo: leftNumberView.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: rightNumberView.trailingAnchor),
      descriptionLabel.heightAnchor.constraint(equalToConstant: 12),
      descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

