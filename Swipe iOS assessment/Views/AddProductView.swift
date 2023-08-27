//
//  AddProductView.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 25/08/23.
//

import SwiftUI

struct AddProductView: View {
    
    @Environment(\.dismiss) var dismiss                                                    // To dismiss this sheet
    var productTypes = ["Electronics", "Phone", "T-Shirt", "Fruit", "Pen","Mobile"]       // Dummy product type array
    
    @State var selectedType = "Phone"                                                    // For product type picker
    @State var productNameString = ""
    @State var productPriceDouble : Double = 0.0
    @State var productTaxDouble : Double = 0.0
    
    @ObservedObject var vm = NetworkManager()                                          // Network manager instance/object
    
    
    var disabled : Bool {                                                             // to disable the add button according to the given conditions
        return productNameString.isEmpty || productPriceDouble == 0 || productPriceDouble < 0 || productTaxDouble < 0
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Product Type", selection: $selectedType) { // Type picker
                        ForEach(productTypes,id:\.self){ type in
                            Text(type)
                        }
                        
                    }
                    .pickerStyle(.menu)
                }
                Section("Product Details"){                                      // Textfields to enter other information about the product
                    TextField("Product Name", text: $productNameString)
                    TextField("Product Price", value: $productPriceDouble, formatter: NumberFormatter())
                    TextField("Product Tax Rate",value:$productTaxDouble,formatter: NumberFormatter())
                }
                Section{
                    Button { // add button
                        let newProduct = ProductType(image: "", price: productPriceDouble, productName: productNameString, productType: selectedType, tax: productTaxDouble)                               // making a new product using the entered data by the user
                        Task{
                            await vm.postCall(productType:newProduct)      // POST method call
                        }
                        selectedType = "Phone"                            // reseting the text fields to its initial value
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
        .alert("POST Call Result", isPresented: $vm.showAlert) {                 // show alert if the call is successful or a failure
            Button(role: .cancel) {                                             // taking the binding bool from the network manager class
                dismiss()
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("\(vm.alertMessage)")
             
                                        // Taking the alert message from the class as well, accessing using the vm object of the network manager class
            
        }
    }
}

