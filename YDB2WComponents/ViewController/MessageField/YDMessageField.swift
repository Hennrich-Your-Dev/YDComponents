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
  public enum FieldStage {
    case normal
    case typing
    case sending
    case error
  }

  enum ActionButtonType {
    case send
    case like
    case reload
    case sending
  }

  // MARK: Properties
  public weak var delegate: YDMessageFieldDelegate?

  var hasUserPhoto: Bool = false

  var actionButtonType: ActionButtonType = .like {
    didSet {
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

      actionButton.setImage(icon, for: .normal)
      actionButton.isHidden = false
      messageField.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
  }

  // MARK: IBOutlets
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var userPhoto: UIImageView!

  @IBOutlet weak var messageField: UITextField! {
    didSet {
      messageField.delegate = self

      messageField.addTarget(self, action: #selector(onTextFieldChange), for: .editingChanged)
    }
  }

  @IBOutlet weak var messageFieldTrailingConstraint: NSLayoutConstraint!

  @IBOutlet weak var actionButton: UIButton!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var errorMessageLabel: UILabel!

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
  }

  // MARK: IBActions
  @IBAction func onAction(_ sender: UIButton?) {
    if actionButtonType == .reload {
      onReloadAction()
      return
    }

    if actionButtonType == .like {
      delegate?.onLike()
      return
    }

    if let message = messageField.text, !message.isEmpty {
      delegate?.sendMessage(message)
      changeStage(.sending)
    }
  }

  // MARK: Actions
  public func changeStage(_ stage: FieldStage) {
    switch stage {
    case .normal:
      normalStage()

    case .typing:
      typingStage()

    case .sending:
      sendingStage()

    case .error:
      errorStage()
    }
  }

  private func onReloadAction() {
    messageFieldTrailingConstraint.constant += 105
    changeStage(.sending)

    if let message = messageField.text {
      delegate?.sendMessage(message)
    }
  }
}

// MARK: Stages
extension YDMessageField {
  func normalStage() {
    activityIndicator.stopAnimating()
    actionButtonType = .send
    errorMessageLabel.isHidden = true
  }

  func typingStage() {
    activityIndicator.stopAnimating()
    actionButtonType = .send
    errorMessageLabel.isHidden = true
  }

  func sendingStage() {
    activityIndicator.startAnimating()
    actionButtonType = .sending
    errorMessageLabel.isHidden = true
  }

  func errorStage() {
    activityIndicator.stopAnimating()
    actionButtonType = .reload
    errorMessageLabel.isHidden = false
    messageFieldTrailingConstraint.constant -= 105
  }
}

// MARK: Text Field Delegate && Text Field stuffs
extension YDMessageField: UITextFieldDelegate {
  @objc func onTextFieldChange(_ textField: UITextField) {
    if textField.text?.isEmpty ?? true {
      actionButton.setImage(UIImage.Icon.thumbsUp, for: .normal)
    } else if textField.text?.count == 1 {
      changeStage(.typing)
    } else {
      actionButton.setImage(UIImage.Icon.send, for: .normal)
    }
  }
}
