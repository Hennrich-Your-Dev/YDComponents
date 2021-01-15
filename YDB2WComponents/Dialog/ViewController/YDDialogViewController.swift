//
//  YDDialogViewController.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 17/11/20.
//

import UIKit
import YDExtensions
import YDB2WAssets

public enum YDDialogType {
  case withIcon
  case simple
}

class YDDialogViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDDialogViewModelDelegate?
  var type: YDDialogType?
  var customIcon: UIImage?
  var customTitle: String?
  var customMessage: String?

  // MARK: IBOutlets
  @IBOutlet weak var contentView: UIView! {
    didSet {
      contentView.layer.cornerRadius = 6
      contentView.layer.applyShadow(alpha: 0.08, blur: 20, spread: -1)
    }
  }

  @IBOutlet weak var icon: UIImageView! {
    didSet {
      icon.image = Icons.thumbDownWired
      icon.tintColor = UIColor.Zeplin.redBranding
    }
  }

  @IBOutlet weak var titleLabel: UILabel!

  @IBOutlet weak var descriptionLabel: UILabel!

  @IBOutlet weak var actionButton: UIButton! {
    didSet {
      actionButton.layer.borderWidth = 1
      actionButton.layer.borderColor = UIColor.Zeplin.colorPrimaryLight.cgColor
      actionButton.layer.cornerRadius = 4
    }
  }

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    if let customIcon = customIcon {
      icon.image = customIcon
    }

    if let type = self.type,
       type == .simple {
      icon.removeFromSuperview()
      view.layoutIfNeeded()
    }

    if let customTitle = customTitle {
      titleLabel.text = customTitle
    }

    if let customMessage = customMessage {
      descriptionLabel.text = customMessage
    }
  }

  // MARK: IBActions
  @IBAction func onAction(_ sender: UIButton) {
    viewModel?.onButtonAction()
  }
}
