//
//  YDTextView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 18/11/20.
//

import UIKit
import YDExtensions

public protocol YDTextViewDelegate {
  func textViewDidChangeSelection(_ textView: UITextView)
  func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool
}

public class YDTextView: UITextView {
  // MARK: Properties
  public var placeHolder: String = ""
  public var defaultTextColor: UIColor? = UIColor(hex: "#666666")
  public var customDelegate: YDTextViewDelegate?

  // MARK: Init
  init() {
    let rect = CGRect(
      x: 0,
      y: 0,
      width: UIWindow.keyWindow?.frame.width ?? 0,
      height: 35
    )

    super.init(frame: rect,textContainer: nil)
    commonInit()
  }

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  // MARK: Actions
  func commonInit() {
    backgroundColor = .clear

    layer.borderWidth = 1
    layer.borderColor = UIColor(hex: "#999999")?.cgColor
    layer.cornerRadius = 8

    isScrollEnabled = false

    font = .systemFont(ofSize: 14)

    delegate = self

    text = placeHolder
    textColor = .lightGray
  }
}

extension YDTextView: UITextViewDelegate {
  public func textViewDidChangeSelection(_ textView: UITextView) {
    customDelegate?.textViewDidChangeSelection(textView)
  }

  public override func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool {
    if customDelegate != nil {
      return customDelegate?.shouldChangeText(in: range, replacementText: text) ?? false
    }

    return true
  }

  public func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = defaultTextColor
    }
  }

  public func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = placeHolder
      textView.textColor = UIColor.lightGray
    }
  }
}
