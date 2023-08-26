//
//  ProductType.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import Foundation

struct ProductType : Codable,Hashable { // Swift type of the API response to convert the JSON object to custom swift type
        
    let image : String?
    let price : Double
    let productName : String
    let productType : String
    let tax : Double
    
    enum CodingKeys : String,CodingKey { // using coding keys because the API response has some keys in the snake case which is not preferred in swift
        
        case image = "image"
        case price = "price"
        case productName = "product_name" // changing this key
        case productType = "product_type" // This key too.
        case tax = "tax"
        
    }

}
