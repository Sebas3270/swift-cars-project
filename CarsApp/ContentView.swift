//
//  ContentView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var userManager = UserManager()
    
    var body: some View {
        TabView{
            CarsView()
                .tabItem(){
                    Image(systemName: "car.fill")
                    Text("Cars")
                }
            PurchasedView(
                userManager: userManager
            )
                .tabItem(){
                    Image(systemName: "bag.fill")
                    Text("Purchased cars")
                }
            ProfileView(
                userManager: userManager
            )
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .navigationBarHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
