//
//  RegisterView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var lastName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("camaro")
                    .resizable()
                    .scaledToFit()
                    .offset(x: CGFloat(-120), y: CGFloat(250))
                
                Circle()
                    .fill(Color.red.opacity(0.15))
                    .offset(x: CGFloat(-100), y: CGFloat(415))
                
                VStack(alignment: .leading){
                    Text("Register")
                        .font(.largeTitle)
                        .bold()
                    Text("Register to begin purchasing")
                        .font(.body)
                        .padding(.bottom, 20)
                    TextField("Name", text: $name)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                    TextField("Last name", text: $lastName)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                    TextField("Phone", text: $phone)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                    Button("Register"){
                        register()
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 300, height: 40)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
                    Button("Already have an account?"){
                        
                    }
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 40)
                    .cornerRadius(10)
                    
                }.offset(x: CGFloat(0), y: CGFloat(-90))
            }
        }.navigationBarHidden(false)
    }
    
    func register() {
        
        userManager.register(name: name, lastName: lastName, phone: phone, email: email, password: password){ result in
            DispatchQueue.main.async {
                if(result == true){
                    @Environment(\.presentationMode) var presentationMode
                }
            }
        }
    }
}

/*struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
*/
