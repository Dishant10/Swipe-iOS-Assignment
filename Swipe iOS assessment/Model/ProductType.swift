//
//  ProductType.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import Foundation

struct ProductType : Codable,Hashable {                 // Swift type of the API response to convert the JSON object to custom swift type
    
    let image : String?
    let price : Double
    let productName : String
    let productType : String
    let tax : Double
    
    enum CodingKeys : String,CodingKey {      // using coding keys because the API response has some keys in the snake case which is not preferred in swift
        
        case image = "image"
        case price = "price"
        case productName = "product_name"         // changing product_name key because it returns as a snake case which is not prefered in swift syntax
        case productType = "product_type"        // product_type key too
        case tax = "tax"
        
    }
    
}
