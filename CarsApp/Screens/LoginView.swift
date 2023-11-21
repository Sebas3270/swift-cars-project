//
//  LoginView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 09/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("ferrari")
                    .resizable()
                    .scaledToFit()
                    .offset(x: CGFloat(100), y: CGFloat(250))
                
                Circle()
                    .fill(Color.red.opacity(0.15))
                    .offset(x: CGFloat(100), y: CGFloat(400))
                
                VStack(alignment: .leading){
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                    Text("Access to begin purchasing")
                        .font(.body)
                        .padding(.bottom, 20)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(15)
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(15)
                    Button("Log In"){
                        logIn()
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 300, height: 40)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
                    Button("Don't have an account?"){
                        
                    }
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 40)
                    .cornerRadius(10)
                    
                }.offset(x: CGFloat(0), y: CGFloat(-75))
            }
        }.navigationBarHidden(false)
    }
    
    func logIn() {
        
        userManager.logIn(email: username, password: password){ result in
            DispatchQueue.main.async {
                if(result == true){
                    print("Log successfull")
                    @Environment(\.presentationMode) var presentationMode
                }else{
                    print("Log failed")
                }
            }
        }
    }
}

/*struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
*/
