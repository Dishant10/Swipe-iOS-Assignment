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
    @State var searchText = ""
    @State var showAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{             // Using ZStack to embed the list view in a view to use on appear on the parent view instead of the child view
                List{          // List view to view the list of products in a scrollable format
                    ForEach(vm.products,id:\.self){ product in
                        
                        // Looping through the list of products returned by the API call that is stored in an array of type ProductType
                        
                        
                        ProductRow(productName: product.productName, productType: product.productType, price: product.price, tax: product.tax,urlString: product.image ?? "")
                    }
                    .listStyle(.plain)
                    .padding([.leading,.trailing],-20)
                    .listRowSeparator(.hidden)            // Hididng the seperator line because we're using a custom row cell
                    //.listRowInsets(EdgeInsets(top: 10, leading: -10, bottom: 10, trailing: -10))
                    .searchable(text: $searchText)
                }
                .onAppear{
                    Task{                   // Using Task because fetching is an async call/function
                        await vm.fetchProducts()
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar(content: { // Adding an add button in the navigation tool bar as well that will present the AddProductView in a sheet for easier access to this screen as mentioned in the assignment pdf
                Button {
                    showAddProductView = true // show add view sheet
                } label: {
                    Text("Add")
                        .padding()
                }
                
            })
            .onReceive(vm.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"),message: Text(vm.error?.localizedDescription ?? ""))
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
