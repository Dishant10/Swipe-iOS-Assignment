//
//  AddProductView.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) var dismiss
    var productTypes = ["Electronics", "Phone", "T-Shirt", "Fruit", "Pen","Mobile"]
    @State var selectedType = "Phone"
    @State var productNameString = ""
    @State var productPriceDouble : Double = 0.0
    @State var productTaxDouble : Double = 0.0
    @ObservedObject var vm = NetworkManager()
//    @State var showAlert : Bool = false
//    @State var alertMessage : String = ""
    
    var disabled : Bool {
        return productNameString.isEmpty || productPriceDouble == 0 || productPriceDouble < 0 || productTaxDouble < 0
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Product Type", selection: $selectedType) {
                        ForEach(productTypes,id:\.self){ type in
                            Text(type)
                        }
                        
                    }
                    .pickerStyle(.menu)
                }
                Section("Product Details"){
                    TextField("Product Name", text: $productNameString)
                    TextField("Product Price", value: $productPriceDouble, formatter: NumberFormatter())
                    TextField("Product Tax Rate",value:$productTaxDouble,formatter: NumberFormatter())
                }
                Section{
                    Button {
                        let newProduct = ProductType(image: "", price: productPriceDouble, productName: productNameString, productType: selectedType, tax: productTaxDouble)
                        Task{
                            await vm.postCall(productType:newProduct)
                        }
                        selectedType = "Phone"
                        productNameString = ""
                        productPriceDouble = 0
                        productTaxDouble = 0
                        
                    } label: {
                        ZStack(alignment:.center){
                            RoundedRectangle(cornerRadius: 20)
                            
                            Text("ADD")
                                .foregroundStyle(.white)
                        }
                        .padding([.trailing,.leading])
                        
                    }
                    .padding()
                }
                .disabled(disabled)
                
            }
            .navigationTitle("Add Products")
        }
        .alert("POST Call Result", isPresented: $vm.showAlert) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
            
//            Button(action: {
//                dismiss()
//            }, label: {
//                Text("Done")
//            })
            
        } message: {
            Text("\(vm.alertMessage)")
        }
    }
}

//#Preview {
//    AddProductView()
//}
