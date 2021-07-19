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
  let activityIndicator = UIActivityIndicatorView(style: .gray)

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
    if let hourAndMinutesAttributedString = configureAttributed(
        hourAndMinutes: chat.hourAndMinutes
    ) {
      attributedString.append(hourAndMinutesAttributedString)
    }

    // Username
    guard let rangeUsername: Range<String.Index> = fullMessage.range(of: name)
    else {
      messageLabel.attributedText = attributedString
      return
    }

    let indexUsername: Int = fullMessage.distance(
      from: fullMessage.startIndex,
      to: rangeUsername.lowerBound
    )

    let nameAttributedString = configureAttributed(
      name: name,
      onIndex: indexUsername,
      withColor: getStageStyle(id: chat.sender.id, moderatorsIds: chatModerators),
      senderId: chat.sender.id
    )
    attributedString.append(nameAttributedString)

    // Message
    let messageAttributedString = configureAttributed(
      deletedMessage: chat.deletedMessage,
      indexUsername: indexUsername,
      nameCount: name.count,
      message: chat.message
    )
    attributedString.append(messageAttributedString)

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

// MARK: Attributed String
extension YDMessageChatTableViewCell {
  private func configureAttributed(
    hourAndMinutes: String
  ) -> NSMutableAttributedString? {
    guard let rangeTime: Range<String.Index> = fullMessage.range(of: hourAndMinutes) else {
      return nil
    }

    let mutableAttributeString = NSMutableAttributedString(string: fullMessage)

    let indexTime: Int = fullMessage.distance(
      from: fullMessage.startIndex,
      to: rangeTime.lowerBound
    )

    let commonRange = NSRange(location: indexTime, length: hourAndMinutes.count)

    mutableAttributeString.addAttribute(
      NSAttributedString.Key.font,
      value: UIFont.systemFont(ofSize: 10, weight: .regular),
      range: commonRange
    )

    mutableAttributeString.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: Zeplin.grayLight,
      range: commonRange
    )

    mutableAttributeString.addAttribute(
      NSAttributedString.Key.kern,
      value: 4,
      range: NSRange(location: indexTime + hourAndMinutes.count, length: 1)
    )

    return mutableAttributeString
  }

  private func configureAttributed(
    name: String,
    onIndex index: Int,
    withColor color: UIColor,
    senderId: String
  ) -> NSMutableAttributedString {
    let mutableAttributedString = NSMutableAttributedString(string: fullMessage)

    mutableAttributedString.addAttribute(
      NSAttributedString.Key.font,
      value: UIFont.systemFont(ofSize: 12, weight: .bold),
      range: NSRange(location: index, length: name.count)
    )

    mutableAttributedString.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: color,
      range: NSRange(location: index, length: name.count)
    )

    mutableAttributedString.addAttribute(
      NSAttributedString.Key.kern,
      value: 6,
      range: NSRange(location: index + name.count, length: 1)
    )

    return mutableAttributedString
  }

  private func configureAttributed(
    deletedMessage: Bool,
    indexUsername: Int,
    nameCount: Int,
    message: String
  ) -> NSMutableAttributedString {
    let mutableAttributedString = NSMutableAttributedString(string: fullMessage)

    if deletedMessage {
      mutableAttributedString.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.italicSystemFont(ofSize: 12),
        range: NSRange(location: indexUsername + nameCount + 1, length: message.count)
      )

      mutableAttributedString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: UIColor.Zeplin.grayLight,
        range: NSRange(
          location: indexUsername + nameCount + 1,
          length: message.utf16.count
        )
      )
      //
    } else {
      mutableAttributedString.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.systemFont(ofSize: 12, weight: .regular),
        range: NSRange(location: indexUsername + nameCount + 1, length: message.count)
      )

      mutableAttributedString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: UIColor.Zeplin.black,
        range: NSRange(location: indexUsername + nameCount + 1, length: message.utf16.count)
      )
    }

    return mutableAttributedString
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
