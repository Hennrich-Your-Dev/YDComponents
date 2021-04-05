//
//  YDOfflineOrdersProduct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 11/03/21.
//
import Foundation

import YDExtensions

public class YDOfflineOrdersProduct: Decodable {
  // MARK: Properties
  private var item: String?
  public var howMany: Int = 1
  public var ean: String?
  public var totalPrice: Double
  public var product: YDProduct?

  // MARK: Computed variables
  public var formatedPrice: String? {
    return totalPrice.formatedPrice
  }

  public var image: String? {
    return product?.image
  }

  public var name: String? {
    return product?.name ?? self.item
  }

  // MARK: Coding Keys
  enum CodingKeys: String, CodingKey {
    case item
    case ean
    case howMany = "qtde"
    case totalPrice = "valorTotalItem"
  }
}
