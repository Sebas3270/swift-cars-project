//
//  ContentView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            TabView{
                CarsView()
                    .tabItem(){
                        Image(systemName: "car.fill")
                        Text("Cars")
                    }
                PurchasedView()
                    .tabItem(){
                        Image(systemName: "bag.fill")
                        Text("Purchased cars")
                    }
                ProfileView()
                    .tabItem(){
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
