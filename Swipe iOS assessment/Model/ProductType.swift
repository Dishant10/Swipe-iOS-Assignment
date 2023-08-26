//
//  ProductType.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import Foundation

struct ProductType : Codable,Hashable {
        
    let image : String?
    let price : Double
    let productName : String
    let productType : String
    let tax : Double
    
    enum CodingKeys : String,CodingKey {
        
        case image = "image"
        case price = "price"
        case productName = "product_name"
        case productType = "product_type"
        case tax = "tax"
        
    }

}
