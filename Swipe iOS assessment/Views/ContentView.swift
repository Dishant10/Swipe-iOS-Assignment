//
//  ContentView.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 22/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
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

#Preview {
    ContentView()
}
