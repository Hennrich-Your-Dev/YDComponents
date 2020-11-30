//
//  YDAPILiveProduct.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 30/11/20.
//

import Foundation

public class YDAPILiveProduct: Codable {
  let id: String
  let name: String
  let component: YDAPILiveProductComponent

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case name, component
  }

  init(
    id: String,
    name: String,
    component: YDAPILiveProductComponent
  ) {
    self.id = id
    self.name = name
    self.component = component
  }
}

// MARK: - Component
class YDAPILiveProductComponent: Codable {
  let id: String
  let type: String
  let showcaseTitle: String
  let children: [YDAPILiveProductChild]

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type, showcaseTitle, children
  }

  init(
    id: String,
    type: String,
    showcaseTitle: String,
    children: [YDAPILiveProductChild]
  ) {
    self.id = id
    self.type = type
    self.showcaseTitle = showcaseTitle
    self.children = children
  }
}

// MARK: - Child
class YDAPILiveProductChild: Codable {
  let id: String
  let productID: String
  let title: String?
  let type: String?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case productID = "productId"
    case title, type
  }

  init(
    id: String,
    productID: String,
    title: String?,
    type: String?
  ) {
    self.id = id
    self.productID = productID
    self.title = title
    self.type = type
  }
}
