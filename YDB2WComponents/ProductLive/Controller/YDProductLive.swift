//
//  YDProductLive.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 30/11/20.
//

import UIKit
import Cosmos

import YDExtensions
import YDB2WAssets

public class YDProductLive: UIView {
  // MARK: Properties
  var config: YDLiveProductConfigurationModel?
  public var callback: (() -> Void)?

  // MARK: IBOutlets
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var photo: UIImageView!

  @IBOutlet weak var photoMask: UIView! {
    didSet {
      photoMask.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
      photoMask.layer.opacity = 0.1
    }
  }

  @IBOutlet weak var ratingView: CosmosView! {
    didSet {
      ratingView.settings.emptyImage = Images.starGrey
      ratingView.settings.filledImage = Images.starYellow
      ratingView.settings.fillMode = .full
      ratingView.settings.starMargin = 2
      ratingView.settings.starSize = 17
      ratingView.settings.totalStars = 5
    }
  }

  @IBOutlet weak var addButton: UIButton! {
    didSet {
      addButton.layer.borderColor = UIColor.Zeplin.colorPrimaryLight.cgColor
      addButton.layer.borderWidth = 1
      addButton.layer.cornerRadius = 4
    }
  }

  @IBOutlet weak var skuLabel: UILabel!

  @IBOutlet weak var nameLabel: UILabel!

  @IBOutlet weak var priceLabel: UILabel!

  @IBOutlet weak var priceConditionsLabel: UILabel!

  @IBOutlet weak var liveView: UIView! {
    didSet {
      liveView.layer.cornerRadius = 8
    }
  }

  // MARK: Life cycle
  public init(with config: YDLiveProductConfigurationModel) {
    let rect = CGRect(x: 0, y: 0, width: config.width, height: config.height)
    super.init(frame: rect)

    self.config = config
    instanceXib()
    applyProduct()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    instanceXib()
  }

  // MARK: IBActions
  @IBAction func onAddAction(_ sender: UIButton) {
    guard let product = config?.product else {
        return
    }

    product.onBasket.toggle()

    let parameters: [String: Any] = [
      "addToCard": product.onBasket,
      "productId": product.id ?? "",
      "sku": product.ean ?? "",
      "seller": product.partnerId ?? "",
      "skipServiceSelling": true,
      "openCartScreenAfterAdd": false
    ]

    NotificationCenter.default.post(
      name: NSNotification.Name("YDLiveAddToCartObserver"),
      object: nil,
      userInfo: parameters
    )

    changeAddToCartButtonStyle(with: product)
  }

  // MARK: Private Actions
  private func instanceXib() {
    contentView = loadNib()
    addSubview(contentView)
    backgroundColor = .clear

    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: self.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }

  private func applyProduct() {
    guard let config = config else {
      return
    }

    let product = config.product

    contentView.layer.cornerRadius = config.radius
    contentView.layer.applyShadow(color: .black, alpha: 0.08, x: 0, y: 6, blur: 20, spread: -1)

    photo.setImage(product.images?.first)
    photo.layer.cornerRadius = config.radius
    photoMask.layer.cornerRadius = config.radius

    changeAddToCartButtonStyle(with: product)

    if let ean = product.ean {
      skuLabel.text = "código: \(ean)"
    } else {
      setUnavailable()
    }

    if let name = product.name {
      nameLabel.text = name
    } else {
      nameLabel.isHidden = true
    }

    if let price = product.getPrice() {
      priceLabel.text = price
    } else {
      setUnavailable()
    }

    if let priceConditions = product.priceConditions {
      priceConditionsLabel.text = priceConditions
    } else {
      priceConditionsLabel.isHidden = true
    }

    if let rating = product.rating,
      rating.reviews >= 1 {
      ratingView.rating = rating.average
    } else {
      ratingView.isHidden = true
    }
  }

  private func changeAddToCartButtonStyle(with product: YDLiveProductModel) {
    if product.onBasket {
      addButton.layer.borderColor = UIColor.gray.cgColor
      addButton.setTitle("adicionado à cesta", for: .normal)
      addButton.setTitleColor(UIColor.gray, for: .normal)
      addButton.isEnabled = false

    } else {
      addButton.layer.borderColor = UIColor.Zeplin.colorPrimaryLight.cgColor
      addButton.setTitle("adicionar a cesta", for: .normal)
      addButton.setTitleColor(UIColor.Zeplin.colorPrimaryLight, for: .normal)
    }
  }

  private func setUnavailable() {
    addButton.isEnabled = false
    addButton.setTitleColor(UIColor.Zeplin.black, for: .disabled)
    addButton.layer.borderColor = UIColor.Zeplin.greyDisabled.cgColor
    addButton.backgroundColor = UIColor.Zeplin.greyDisabled
  }

  // MARK: Public Actions
  public func config(with config: YDLiveProductConfigurationModel) {
    self.config = config
    applyProduct()
  }
}
