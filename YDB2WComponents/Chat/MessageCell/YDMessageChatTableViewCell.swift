//
//  YDMessageChatTableViewCell.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 19/07/21.
//

import UIKit
import YDExtensions
import YDB2WModels

public class YDMessageChatTableViewCell: UITableViewCell {
  // MARK: Enum
  public enum MessageStage {
    case normal
    case americanas
    case myself
  }

  // MARK: Properties
  var currentMessage: YDChatMessage?
  var currentUserId: String = ""
  var fullMessage = ""

  // MARK: Components
  let messageLabel = UILabel()
  let replyMessageComponent = YDReplyMessageComponent()
  lazy var replyMessageTop: NSLayoutConstraint = {
    let top = replyMessageComponent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6)
    top.isActive = true
    return top
  }()
  lazy var replyMessageHeight: NSLayoutConstraint = {
    let height = replyMessageComponent.heightAnchor.constraint(equalToConstant: 34)
    height.isActive = true
    return height
  }()
  let activityIndicator = UIActivityIndicatorView(style: .medium)

  // MARK: Life cycle
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    configureLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func prepareForReuse() {
    fullMessage = ""
    currentMessage = nil
    backgroundColor = .clear
    super.prepareForReuse()
  }

  // MARK: Config
  public func config(
    with chat: YDChatMessage,
    currentUserId: String,
    chatModerators: [String]
  ) {
    self.currentMessage = chat
    self.currentUserId = currentUserId

    if chat.recentAdded {
      DispatchQueue.main.async { [weak self] in
        self?.backgroundColor = UIColor.Zeplin.graySurface

        UIView.animate(withDuration: 1, delay: 0.5) { [weak self] in
          self?.backgroundColor = .clear
        } completion: { _ in
          chat.recentAdded = false
        }
      }
    }

    applyAttributedStrings(chat: chat, chatModerators: chatModerators)
  }

  // MARK: Actions Public
  public func hasReplyMessage(message: YDChatMessage) {
    replyMessageTop.constant = 6
    replyMessageHeight.constant = 34
    replyMessageComponent.configure(with: message)
  }

  public func showActivity() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.activityIndicator.startAnimating()
    }
  }

  public func hideActivity() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.activityIndicator.stopAnimating()
    }
  }

  // MARK: Private
  func applyAttributedStrings(chat: YDChatMessage, chatModerators: [String]) {
    let isModerator = chatModerators.contains(chat.sender.id) ? true : false
    let name = isModerator ? "Americanas" : chat.sender.name

    fullMessage = "\(chat.hourAndMinutes) \(name) \(chat.message)"

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 1
    paragraphStyle.lineHeightMultiple = 0

    let attributedString = NSMutableAttributedString(
      string: fullMessage,
      attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
    )

    // Time
    guard let rangeTime: Range<String.Index> = fullMessage.range(of: chat.hourAndMinutes) else {
      return
    }

    let indexTime: Int = fullMessage.distance(
      from: fullMessage.startIndex,
      to: rangeTime.lowerBound
    )

    attributedString.addAttribute(
      NSAttributedString.Key.font,
      value: UIFont.systemFont(ofSize: 10, weight: .regular),
      range: NSRange(location: indexTime, length: chat.hourAndMinutes.count)
    )

    attributedString.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: UIColor.Zeplin.grayLight,
      range: NSRange(location: indexTime, length: chat.hourAndMinutes.count)
    )

    attributedString.addAttribute(
      NSAttributedString.Key.kern,
      value: 4,
      range: NSRange(location: indexTime + chat.hourAndMinutes.count, length: 1)
    )

    // Username
    guard let rangeUsername: Range<String.Index> = fullMessage.range(of: name) else {
      return
    }

    let indexUsername: Int = fullMessage.distance(
      from: fullMessage.startIndex,
      to: rangeUsername.lowerBound
    )

    attributedString.addAttribute(
      NSAttributedString.Key.font,
      value: UIFont.systemFont(ofSize: 12, weight: .bold),
      range: NSRange(location: indexUsername, length: name.count)
    )

    attributedString.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: getStageStyle(id: chat.sender.id, moderatorsIds: chatModerators),
      range: NSRange(location: indexUsername, length: name.count)
    )

    attributedString.addAttribute(
      NSAttributedString.Key.kern,
      value: 6,
      range: NSRange(location: indexUsername + name.count, length: 1)
    )

    // Message
    if chat.deletedMessage {
      attributedString.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.italicSystemFont(ofSize: 12),
        range: NSRange(location: indexUsername + name.count + 1, length: chat.message.count)
      )

      attributedString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: UIColor.Zeplin.grayLight,
        range: NSRange(location: indexUsername + name.count + 1, length: chat.message.utf16.count)
      )

      //
    } else {
      attributedString.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.systemFont(ofSize: 12, weight: .regular),
        range: NSRange(location: indexUsername + name.count + 1, length: chat.message.count)
      )

      attributedString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: UIColor.Zeplin.black,
        range: NSRange(location: indexUsername + name.count + 1, length: chat.message.utf16.count)
      )
    }

    messageLabel.attributedText = attributedString
  }

  func getStageStyle(id: String, moderatorsIds: [String]) -> UIColor {
    if moderatorsIds.contains(id) {
      return getAmericanasStage()
    }

    switch id {
      case currentUserId:
        return getMyselfStage()

      default:
        return getNormalStage()
    }
  }

  func getNormalStage() -> UIColor {
    return UIColor.Zeplin.grayLight
  }

  func getAmericanasStage() -> UIColor {
    return UIColor.Zeplin.colorPrimaryLight
  }

  func getMyselfStage() -> UIColor {
    return UIColor.Zeplin.black
  }
}

// MARK: Layout
extension YDMessageChatTableViewCell {
  func configureLayout() {
    configureReplyMessageComponent()
    configureMessageLabel()
    configureActivityIndicator()
  }

  func configureReplyMessageComponent() {
    contentView.addSubview(replyMessageComponent)
    replyMessageComponent.stage = .replied

    replyMessageComponent.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      replyMessageComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      replyMessageComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
    replyMessageTop.constant = 0
    replyMessageHeight.constant = 0
  }

  func configureMessageLabel() {
    contentView.addSubview(messageLabel)
    messageLabel.textColor = Zeplin.black
    messageLabel.font = .systemFont(ofSize: 12)
    messageLabel.textAlignment = .left
    messageLabel.numberOfLines = 0

    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(
        equalTo: replyMessageComponent.bottomAnchor,
        constant: 6
      ),
      messageLabel.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: 12
      ),
      messageLabel.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -6
      )
    ])
  }

  func configureActivityIndicator() {
    contentView.addSubview(activityIndicator)
    activityIndicator.hidesWhenStopped = true
    // activityIndicator.color = Zeplin.redBranding

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.topAnchor.constraint(equalTo: messageLabel.topAnchor),
      activityIndicator.trailingAnchor
        .constraint(equalTo: contentView.trailingAnchor, constant: -12),

      messageLabel.trailingAnchor
        .constraint(equalTo: activityIndicator.leadingAnchor, constant: -6)
    ])
  }
}
