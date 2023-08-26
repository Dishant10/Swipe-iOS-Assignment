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
//                    AsyncImage(url: URL(string: urlString)){ phase in
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
                    AsyncImage(url: URL(string: urlString)) { image in
                        image
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    } placeholder: {
                        Image(systemName: "person.fill")
                    }
                }
                .frame(width: 100,height: 100)
                .padding([.leading])
                Spacer()
                VStack(alignment:.leading){
                    Text("\(productName)")
                        .fontWeight(.heavy)
                        .lineLimit(1)
                    //.font(.title)
                    Text("\(productType)")
                        .lineLimit(1)
                    Text("Price : \(price)")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    Text("Tax : \(tax)")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .padding(.trailing)
            }
            .padding([.top,.bottom])
        }
    }
}

#Preview {
    ProductRow(productName: "iPhone", productType: "Smart Phone", price: 1000, tax: 13,urlString: "")
}
