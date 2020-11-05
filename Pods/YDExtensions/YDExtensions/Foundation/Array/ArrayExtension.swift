//
//  ArrayExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 02/11/20.
//

import Foundation

public extension Array {

  func at(_ index: Int) -> Element? {
    return 0 <= index && index < count ? self[index] : nil
  }
}
