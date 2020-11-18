//
//  YDDialogViewController.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 17/11/20.
//

import UIKit
import YDExtensions

class YDDialogViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDDialogViewModelDelegate?
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

  @IBOutlet weak var icon: UIImageView!

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

    if let customTitle = customTitle {
      titleLabel.text = customTitle
    }

    if let customMessage = customMessage {
      descriptionLabel.text = customMessage
    }
  }

  // MARK: IBActions
  @IBAction func onAction(_ sender: UIButton) {
    viewModel?.onButton()
  }
}
