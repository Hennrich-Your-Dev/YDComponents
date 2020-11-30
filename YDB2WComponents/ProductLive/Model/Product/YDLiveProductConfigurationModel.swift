//
//  YDLiveProductConfigurationModel.swift
//  YDLiveProduct
//
//  Created by Douglas Hennrich on 31/08/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit

import YDExtensions

public class YDLiveProductConfigurationModel {

	// MARK: Properties
	let width: CGFloat
	let height: CGFloat
	let backgroundColor: UIColor
	let radius: CGFloat
	let product: YDLiveProductModel

	// MARK: Init
	public init(
		withWidth width: CGFloat = 300,
		withHeight height: CGFloat = 203,
		withBackgroundColor backgroundColor: UIColor = UIColor.Zeplin.white,
		withRadius radius: CGFloat = 6,
		withProduct product: YDLiveProductModel
	) {
		self.width = width
		self.height = height
		self.backgroundColor = backgroundColor
		self.radius = radius
		self.product = product
	}

}
