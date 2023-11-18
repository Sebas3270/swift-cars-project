//
//  CarView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 16/11/23.
//

import SwiftUI

struct CarView: View {
    
    var car: Car
    @State var performLogIn = false
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: car.imagen)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                Color.gray
            }.cornerRadius(5)
            Text("Precio: $\(String(format: "%.2f", car.precio))")
            Spacer()
            HStack{
                
                Spacer()
                Button("Buy"){
                    
                }
                .foregroundColor(Color.white)
                .frame(width: 350, height: 40)
                .background(Color.red.opacity(0.8))
                .cornerRadius(10)
                .onTapGesture {
                    buyCar()
                }
                Spacer()
                
            }
            
        }
        .padding(10)
        .navigationTitle(car.submarca.capitalized)
        .accentColor(.red)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Log In Required"),
                message: Text("You need to have an account to buy a car"),
                dismissButton: .default(Text("OK"))
                /*primaryButton: .default(Text("OK")),
                secondaryButton: .cancel()*/
            )
        }
        /*.background(
         NavigationLink(
         destination: LoginView(),
         isActive: $performLogIn,
         label: { EmptyView() }
         )
         )*/
        
        
        
    }
    
    func buyCar(){
        let userManager = UserManager.shared
        
        if !userManager.isLogged {
            //print("Entered")
            self.showAlert.toggle()
            
        }
    }
}

struct CarView_Previews: PreviewProvider {
    static var previews: some View {
        CarView(car: Car(id: 100, serie: "prueba", color: "azul", cilindros: 5, idMarca: 9, submarca: "Chevrolet Aveo", modelo: 2022, puertas: 4, precio: 50000.45, idSegmento: 2, imagen: "https://i.ytimg.com/vi/r8Zyg5x-5Vo/maxresdefault.jpg", estatus: 0, fechaVenta: nil, fechaCreacion: nil, fechaModificacion: nil))
    }
}

