//
//  ContentView.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 22/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{ // Using tab views for easier navigation between the two screens. It is proven that tab views are very intuitive.
            ProductListView()
                .tabItem {
                    VStack{
                        Image(systemName: "bag.fill")
                        Text("Products")
                    }
                    
                }
            AddProductView()
                .tabItem {
                    VStack{
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }
        }
    }
}

//#Preview {
//    ContentView()
//}
