//
//  NetworkManager.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import Foundation
import Alamofire // using alamofire library because it makes the POST request easier and handles error gracefully
import SwiftUI



final class NetworkManager : ObservableObject {
    
    @Published var products : [ProductType] = []        // product array
    @Published var showAlert : Bool = false            // alert binding bool
    @Published var alertMessage : String = ""         // alert message
    @Published var error : Error?
    
    init(){
        products = []
        showAlert = false
        alertMessage = ""
        Task{
            await self.fetchProducts()
        }
        
    }
    func fetchProducts() async {                                                 // async function to fetch data from the given API
        
        let urlString = "https://app.getswipe.in/api/public/get"                // hardcoded url string
        guard let url = URL(string: urlString) else{                           // URL type using the url string
            DispatchQueue.main.async {
                self.error = NetworkError.invalidURL
            }
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in       // using URLSession to perform the GET request
            
            if let error = error {
                DispatchQueue.main.async {
                    self.error = NetworkError.unkown(error)
                }
                
                return
            }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else{
                DispatchQueue.main.async {
                    self.error = NetworkError.serverEror
                }
                return
            }
            let decoder = JSONDecoder()
            
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            // Since we used coding keys to handle snake case with our custom key names, we do not need to add another keyDecodingStrategy
            
            guard let data = data else{
                DispatchQueue.main.async {
                    self.error = NetworkError.invalidData
                }
                return
            }
            guard let result = try? decoder.decode([ProductType].self , from: data)
            else{
                DispatchQueue.main.async {
                    self.error = NetworkError.invalidData
                }
                return
            }
            DispatchQueue.main.async {
                
                // updating UI on the main thread because async functions and network calls are done on the background threads
                
                self.products = result
            }
        }
        .resume()
    }
    
    
    func sendProducts(productType : ProductType) async {                              // POST request using URLSession
        
        let urlString = "https://app.getswipe.in/api/public/add"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)                                           // Creating a request using the URL
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"                                                 // POST method
        let body : [String:AnyHashable] = [                                        // body data
            "product_name" : "new",
            "product_type" : "nothing",
            "price" : 200.0,
            "tax" : 5.1
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options:.fragmentsAllowed)    // Encoding data into JSON type
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)       // receiving reponse data after POST request
                print(response)
            }
            catch{
                print("Checkout Failed")
            }
        }
        task.resume()
    }
    
    func postCall(productType : ProductType) async {                     // POST call using alamofire
        
        let body : [String:AnyHashable] = [                             // body data in JSON format
            "product_name" : productType.productName,
            "product_type" : productType.productType,
            "price" : productType.price,
            "tax" : productType.tax
        ]
        let urlString = "https://app.getswipe.in/api/public/add"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        let headers:HTTPHeaders=[ // header type
            "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"]            // sending using form-data as url encoded format
        
        AF.request(url,method: .post,parameters: body,encoding: URLEncoding.httpBody, headers: headers).responseJSON{response in // POST request call
            switch response.result {              // returns a result type which can be up of type success or failure and needs to be handled accordingly
            case .success(let JSON):
                self.showAlert.toggle()
                self.alertMessage = "Successfully added the new product item"     // show success alert message
                //print(JSON)
            case .failure(let error):
                self.showAlert.toggle()
                self.alertMessage = "Error adding this product listing to the catalogue"   // show failure alert message
                //                print(error)
            }
        }
        
    }
    
}
