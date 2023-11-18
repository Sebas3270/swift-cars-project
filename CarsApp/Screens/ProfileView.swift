//
//  ProfileView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    private var isLogged = UserManager.shared.isLogged
    
    var body: some View {
        NavigationView{
            
            
            VStack{
                if isLogged {
                    
                }else{
                    NavigationLink("LogIn with an existinig account") {
                        LoginView()
                    }
                    
                    NavigationLink("Register a new account") {
                        RegisterView()
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
