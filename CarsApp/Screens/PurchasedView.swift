//
//  PurchasedView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import SwiftUI

struct PurchasedView: View {
    
    private var token = TokenManager.shared.authToken
    
    @State private var dataResult: Result<[PurchasedCar], NetworkError>? = nil
    
    var body: some View {
        NavigationView{
            
            if token == nil {
                Text("No token")
            }else{
                
                VStack {
                    switch dataResult {
                    case .none:
                        Text("Loading...")
                            .onAppear(perform: loadData)
                    case .some(.failure(let error)):
                        // Handle failure
                        Text("Error: \(error.localizedDescription)")
                    case .some(.success(let cars)):
                        //Text("Hi")
                        List(cars) { car in
                            
                            HStack {
                                AsyncImage(url: URL(string: car.imagen!)){ image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    Color.gray
                                }.frame(width: 120)
                                    .cornerRadius(5)
                                    .padding(10)
                                
                                VStack(alignment: .leading){
                                    Text(car.submarca!.capitalized)
                                        .bold()
                                        .font(.system(size: 22))
                                    Text(String(car.modelo!))
                                        .padding(.bottom, 5)
                                    
                                    Text("$\(String(format: "%.2f", car.precio!))")
                                }
                            }
                            
                        }
                    }
                }.navigationTitle("Available cars")
                
            }
            
        }
        
        
        
    }
    
    func loadData() {
        
        let userManager = UserManager.shared
        
        userManager.getPurchasedCars(){ result in
            DispatchQueue.main.async {
                self.dataResult = result
            }
        }
    }
}

struct PurchasedView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasedView()
    }
}
