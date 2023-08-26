//
//  NetworkManager.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import Foundation
import Alamofire
import SwiftUI

final class NetworkManager : ObservableObject {
    
    @Published var products : [ProductType] = []
    
    @Published var showAlert : Bool = false
    @Published var alertMessage : String = ""
    
    init(){
        products = []
        showAlert = false
        alertMessage = ""
        Task{
            await self.fetchProducts()
        }
        
    }
    func fetchProducts() async {
        let urlString = "https://app.getswipe.in/api/public/get"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url){  data, response, error in
            if let error = error {
                print(error)
            }
            else{
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data2 = data {
                    print(data2)
                    do{
                        let result = try decoder.decode([ProductType].self , from: data2)
                        DispatchQueue.main.async {
                            //print(result)
                            self.products = result
                        }
                    }
                    catch{
                        print("Error fetching data")
                    }
                }
                else{
                    print("No Data")
                }
            }
        }
        .resume()
    }
    
    
    func sendProducts(productType : ProductType) async {
        //let encoder = JSONEncoder()
        //guard let data = try? encoder.encode(productType)
//        else {
//            print("Failed to encode")
//            return
//        }
        let urlString = "https://app.getswipe.in/api/public/add"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body : [String:AnyHashable] = [
            "product_name" : "new",
            "product_type" : "nothing",
            "price" : 200.0,
            "tax" : 5.1
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options:.fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                print(response)
            }
            catch{
                print("Checkout Failed")
            }
        }
        task.resume()
    }
    
    func postCall(productType : ProductType) async {
        
        let body : [String:AnyHashable] = [
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
        let headers:HTTPHeaders=[
                "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"]
        
        AF.request(url,method: .post,parameters: body,encoding: URLEncoding.httpBody, headers: headers).responseJSON{response in
            switch response.result {
            case .success(let JSON):
                self.showAlert.toggle()
                self.alertMessage = "Successfully added the new product item"
                print(JSON)
            case .failure(let error):
                self.showAlert.toggle()
                self.alertMessage = "Error adding this product listing to the catalogue"
                print(error)
            }
        }
        
    }
    
}
