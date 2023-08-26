//
//  ProductListView.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject var vm = NetworkManager()
    @State var showAddProductView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(vm.products,id:\.self){ product in
                        ProductRow(productName: product.productName, productType: product.productType, price: product.price, tax: product.tax,urlString: product.image ?? "")
                    }
                    .listStyle(.plain)
                    .padding([.leading,.trailing],-20)
                    .listRowSeparator(.hidden)
                    //.listRowInsets(EdgeInsets(top: 10, leading: -10, bottom: 10, trailing: -10))
                }
                .onAppear{
                    Task{
                        await vm.fetchProducts()
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar(content: {
                Button {
                    showAddProductView = true
                } label: {
                    Text("Add")
                        .padding()
                }

            })
        }
        .sheet(isPresented: $showAddProductView, content: {
            AddProductView()
        })
        .onAppear(perform: {
            Task{
                await vm.fetchProducts()
            }
        })
    }
}

//#Preview {
//    ProductListView()
//}
