//
//  ProfileView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    /*private var isLogged = UserManager.shared.isLogged
    private var user = UserManager.shared.user*/
    @ObservedObject var userManager: UserManager
    
    var body: some View {
        NavigationView{
            
            
            VStack(alignment: .leading){
                if userManager.isLogged {
                    Group{
                        Text("Nombre: \(userManager.user!.nombre) \(userManager.user!.apellidos)")
                        Text("Correo: \(userManager.user!.correo)")
                        Text("Telefono: \(userManager.user!.telefono)")
                        Text("Log Out")
                            .padding(.top, 16)
                            .foregroundColor(.red)
                            .onTapGesture {
                                userManager.logOut()
                            }
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,16)
                        
                    Spacer()
                }else{
                    NavigationLink("LogIn with an existinig account") {
                        LoginView(
                            userManager: userManager
                        )
                    }
                    
                    NavigationLink("Register a new account") {
                        RegisterView(
                            userManager: userManager
                        )
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

/*struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
*/
