//
//  YDLiveProduct.swift
//  ObjB2WBarcodeScanner
//
//  Created by Douglas Hennrich on 13/08/20.
//  Copyright © 2020 Objective Solutions. All rights reserved.
//

import UIKit

public class YDLiveProductModel: Codable {
  public var description: String?
  public var id: String?
  public var images: [String]?
  public var name: String?
  public var price: String?
  public var priceConditions: String?
  public var ean: String?
  public var rating: YDLiveProductModelRating?
  public var partnerId: String?
  public var stock: Bool = false
  public var onBasket: Bool = true

  public var productAvailable: Bool {
    if stock || price != nil || ean != nil {
      return true
    }

    return false
  }

  public init(
    description: String?,
    id: String?,
    images: [String]?,
    name: String?,
    price: String?,
    priceConditions: String?,
    ean: String?,
    rating: YDLiveProductModelRating?,
    partnerId: String?,
    stock: String?,
    onBasket: Bool = false
  ) {
    self.description = description
    self.id = id
    self.images = images
    self.name = name
    self.price = price
    self.priceConditions = priceConditions
    self.ean = ean
    self.rating = rating
    self.partnerId = partnerId
    self.onBasket = onBasket
    self.stock = stock == "true"
  }

  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    description = try? container.decode(
      String.self,
      forKey: .description
    )

    id = try? container.decode(
      String.self,
      forKey: .id
    )

    images = try? container.decode(
      [String].self,
      forKey: .images
    )

    name = try? container.decode(
      String.self,
      forKey: .name
    )

    price = try? container.decode(
      String.self,
      forKey: .price
    )

    priceConditions = try? container.decode(
      String.self,
      forKey: .priceConditions
    )

    ean = try? container.decode(
      String.self,
      forKey: .ean
    )

    rating = try? container.decode(
      YDLiveProductModelRating.self,
      forKey: .rating
    )

    partnerId = try? container.decode(String.self, forKey: .partnerId)

    if let stockString = try? container.decode(String.self, forKey: .stock) {
      stock = stockString == "true"
    } else {
      stock = false
    }

    onBasket = false
  }

  public static func mock() -> YDLiveProductModel {
    return YDLiveProductModel(description: nil, id: nil, images: nil, name: nil, price: nil, priceConditions: nil, ean: nil, rating: nil, partnerId: nil, stock: nil)
  }
}

//extension YDLiveProductModel {
//  public func getPrice() -> String? {
//    guard let price = price else { return nil }
//    let formatter = NumberFormatter()
//    formatter.alwaysShowsDecimalSeparator = true
//    formatter.locale = Locale(identifier: "pt_br")
//    formatter.numberStyle = .currency
//
//    return formatter.string(for: price)
//  }
//}
