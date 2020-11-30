//
//  YDLiveProductRating.swift
//  ObjB2WBarcodeScanner
//
//  Created by Douglas Hennrich on 13/08/20.
//  Copyright © 2020 Objective Solutions. All rights reserved.
//

import Foundation

public struct YDLiveProductModelRating: Codable {
    
    let average: Double
    
    let recommendations: Int
    
    let reviews: Int

	public init(average: Double, recommendations: Int, reviews: Int) {
		self.average = average
		self.recommendations = recommendations
		self.reviews = reviews
	}
    
}
