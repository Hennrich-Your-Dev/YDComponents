//
//  YDProductCardView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 25/03/21.
//

import UIKit

import Cosmos
import YDExtensions
import YDB2WModels
import YDB2WAssets
import YDUtilities

public class YDProductCardView: UIView {
  // MARK: Properties
  public var stateView: YDUIStateEnum = .normal {
    didSet {
      changeUIState(with: stateView)
    }
  }
  public var product: YDProduct? {
    didSet {
      updateLayoutWithProduct()
    }
  }
  var itsOnline = false
  var shimmers: [UIView] = []

  // MARK: Components
  let container = UIView()
  let photoImageView = UIImageView()
  let photoImageMask = UIView()
  let productNameLabel = UILabel()
  let productPriceLabel = UILabel()
  let shippingLabel = UILabel()
  let buyButton = UIButton()
  let ratingView = CosmosView()

  let shimmerContainer = UIView()
  let shimmerPhoto = UIView()
  let shimmerProductName = UIView()
  let shimmerProductRate = UIView()
  let shimmerProductPrice = UIView()

  // MARK: Init
  public override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.Zeplin.white
    layer.applyShadow(x: 0, y: 0, blur: 20)
    heightAnchor.constraint(equalToConstant: 120).isActive = true
    setUpLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(fromOnline: Bool) {
    super.init(frame: .zero)
    itsOnline = fromOnline
    backgroundColor = UIColor.Zeplin.white
    layer.applyShadow(x: 0, y: 0, blur: 20)
    heightAnchor.constraint(equalToConstant: 120).isActive = true
    setUpLayout()
  }

  // MARK: Actions
  private func updateLayoutWithProduct() {
    guard let product = self.product else { return }

    photoImageView.setImage(product.image, placeholder: Icons.imagePlaceHolder)
    productNameLabel.text = product.name?.lowercased()
    productPriceLabel.text = product.formatedPrice

    if itsOnline { return }

    if let rate = product.rating?.average,
       rate > 0,
       let rateText = product.rating?.recommendations {
      ratingView.isHidden = false
      ratingView.rating = rate
      ratingView.text = "(\(rateText))"
    } else {
      ratingView.isHidden = true
    }
  }
}
