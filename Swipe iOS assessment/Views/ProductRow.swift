//
//  ProductRow.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import SwiftUI

struct ProductRow: View {
    
    let productName : String
    let productType : String
    let price : Double
    let tax : Double
    let urlString : String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity,maxHeight:260)
                .foregroundStyle(.gray)
                .opacity(0.4)
            HStack(spacing:20){
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.gray)
                    //                    AsyncImage(url: URL(string: urlString)){ phase in           //other way of using Async Image
                    //                        switch phase {
                    //                        case .empty :
                    //                            ProgressView()
                    //                        case .success(let image):
                    //                            image
                    //                                .resizable()
                    //                                .clipShape(RoundedRectangle(cornerRadius: 20))
                    //                        case .failure:
                    //                            Image(systemName: "person.fill")
                    //                        default :
                    //                            Image(systemName: "person.fill")
                    //
                    //                        }
                    //                    }
                    AsyncImage(url: URL(string: urlString)) { image in            // Async Image to load from a url else use a default placeholder image
                        image
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    } placeholder: {
                        Image(systemName: "person.fill")
                    }
                }
                .frame(width: 100,height: 100)
                .padding([.leading])
                .padding([.leading])
                Spacer()
                VStack(alignment:.leading){
                    Text("\(productName)")
                        .fontWeight(.heavy)
                        .lineLimit(1)
                    Text("\(productType)")
                        .lineLimit(1)
                    Text("Price : \(price.formatted())")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    Text("Tax : \(tax.formatted()) %")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .frame(width:150,height:150,alignment: .leading)
                .padding(.trailing)
            }
            .padding([.top,.bottom])
        }
    }
}

//#Preview {
//    ProductRow(productName: "iPhone", productType: "Smart Phone", price: 1000, tax: 13,urlString: "")
//}
