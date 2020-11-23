//
//  YDMessageField.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 22/10/20.
//

import UIKit
import YDExtensions

public class YDMessageField: UIView {
  // MARK: Enum
  public enum FieldStage: String {
    case normal
    case typing
    case sending
    case error
    case delay
  }

  enum ActionButtonType: String {
    case send
    case like
    case reload
    case sending
    case delay
  }

  // MARK: Properties
  public weak var delegate: YDMessageFieldDelegate?

  public var delayInterval: TimeInterval = 5

  var hasUserPhoto: Bool = false

  var actionButtonType: ActionButtonType = .like {
    didSet {
      if oldValue == .reload || oldValue == .delay {
        messageFieldTrailingConstraint.constant -= 108
      }

      if actionButtonType == .delay {
        return
      }

      if actionButtonType == .sending {
        actionButton.isHidden = true
        messageField.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        return
      }

      let icon: UIImage? = {
        if actionButtonType == .send {
          return UIImage.Icon.send
        }

        if actionButtonType == .like {
          return UIImage.Icon.thumbsUp
        }

        return UIImage.Icon.reload
      }()

      actionButton.setImage(actionButtonType == .like ? UIImage.Icon.thumbsUpRed : nil, for: .selected)
      actionButton.setImage(icon, for: .normal)
      actionButton.isHidden = false
      messageField.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
  }

  var sendTimer: Timer?

  // MARK: IBOutlets
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var messageField: UITextField! {
    didSet {
      messageField.delegate = self

      messageField.addTarget(self, action: #selector(onTextFieldChange), for: .editingChanged)
      messageField.addTarget(self, action: #selector(onTextFieldFocus), for: .editingDidBegin)
      messageField.addTarget(self, action: #selector(onTextFieldBlur), for: .editingDidEnd)

      messageField.attributedPlaceholder = NSAttributedString(
        string: "Escreva algo...",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.Zeplin.greyNight]
      )
    }
  }

  @IBOutlet weak var messageLimitCount: UILabel!

  @IBOutlet weak var messageFieldTrailingConstraint: NSLayoutConstraint!

  @IBOutlet weak var actionButton: UIButton!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var errorMessageLabel: UILabel!

  @IBOutlet weak var delayMessageLabel: UILabel!

  // MARK: Life cycle
  public override init(frame: CGRect) {
    super.init(frame: frame)
    instanceXib()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    instanceXib()
  }

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

    changeStage(.normal)
  }

  // MARK: IBActions
  @IBAction func onAction(_ sender: UIButton?) {
    if actionButtonType == .reload {
      onReloadAction()
      return
    }

    if actionButtonType == .like {
      actionButton.isSelected = true
      delegate?.onLike()

      Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
        self?.actionButton.isSelected = false
      }
      return
    }

    if let message = messageField.text, !message.isEmpty {
      changeStage(.sending)
      delegate?.sendMessage(message)
    }
  }

  // MARK: Actions
  private func onReloadAction() {
    changeStage(.sending)

    if let message = messageField.text {
      delegate?.sendMessage(message)
    }
  }

  // MARK: Public actions
  public func changeStage(_ stage: FieldStage) {
    switch stage {
    case .normal:
      normalStage()

    case .typing:
      typingStage()

    case .sending:
      sendingStage()

    case .delay:
      delayStage()

    case .error:
      errorStage()
    }
  }

  public func config(username: String) {
    messageField.attributedPlaceholder = NSAttributedString(
      string: "Escreva algo, \(username)...",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.Zeplin.greyNight]
    )
  }

  public func cleanField() {
    messageField.text = nil
  }

  public func focusField() {
    messageField.becomeFirstResponder()
  }

  public func blurField() {
    messageField.resignFirstResponder()

    if messageField.text?.isEmpty ?? false {
      changeStage(.normal)
    }
  }
}

// MARK: Stages
extension YDMessageField {
  func normalStage() {
    actionButtonType = .like

    activityIndicator.stopAnimating()

    errorMessageLabel.isHidden = true
    delayMessageLabel.isHidden = true

    messageField.text = nil
    messageField.resignFirstResponder()
    messageLimitCount.isHidden = true

    sendTimer?.invalidate()
  }

  func typingStage() {
    activityIndicator.stopAnimating()
    actionButtonType = .send
    errorMessageLabel.isHidden = true
    delayMessageLabel.isHidden = true
    sendTimer?.invalidate()
  }

  func sendingStage() {
    activityIndicator.startAnimating()
    actionButtonType = .sending
    errorMessageLabel.isHidden = true
    delayMessageLabel.isHidden = true

    sendTimer?.invalidate()
    sendTimer = Timer.scheduledTimer(
      withTimeInterval: delayInterval,
      repeats: false
    ) { [weak self] _ in
      self?.changeStage(.delay)
    }
  }

  func delayStage() {
    actionButtonType = .delay
    errorMessageLabel.isHidden = true
    delayMessageLabel.isHidden = false
    messageFieldTrailingConstraint.constant += 108
  }

  func errorStage() {
    activityIndicator.stopAnimating()
    actionButtonType = .reload
    errorMessageLabel.isHidden = false
    delayMessageLabel.isHidden = true
    messageFieldTrailingConstraint.constant += 108
    messageField.resignFirstResponder()
    messageLimitCount.isHidden = true
    sendTimer?.invalidate()
  }
}

// MARK: Text Field Delegate
extension YDMessageField: UITextFieldDelegate {
  @objc func onTextFieldChange(_ textField: UITextField) {
    if textField.text?.count == 1 {
      changeStage(.typing)
    } else {
      if actionButtonType == .reload {
        errorMessageLabel.isHidden = true
      }

      actionButtonType = .send
    }

    messageLimitCount.text = "\(textField.text?.count ?? 0)/120"
  }

  @objc func onTextFieldFocus() {
    messageLimitCount.isHidden = false
    changeStage(.typing)
  }

  @objc func onTextFieldBlur() {
    if messageField.text?.isEmpty ?? true {
      changeStage(.normal)
    }
  }

  public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    let currentText = textField.text ?? ""

    // make sure the result is under 16 characters
    return currentText.count <= 120
  }

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    onAction(nil)
    return true
  }
}
