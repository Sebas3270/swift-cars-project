//
//  CarsView.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 10/11/23.
//

import SwiftUI

struct CarsView: View {
    
    @ObservedObject var userManager: UserManager
    @State private var dataResult: Result<[Car], NetworkError>? = nil
    
    var body: some View {
        NavigationView{
            VStack {
                switch dataResult {
                case .none:
                    Text("Loading...")
                        .onAppear(perform: loadData)
                case .some(.failure(let error)):
                    // Handle failure
                    Text("Error: \(error.localizedDescription)")
                case .some(.success(let cars)):
                    List(cars) { car in
                        NavigationLink(destination: CarView(car: car, userManager: userManager)){
                            HStack {
                                AsyncImage(url: URL(string: car.imagen)){ image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    Color.gray
                                }.frame(width: 120)
                                    .cornerRadius(5)
                                    .padding(10)
                                
                                VStack(alignment: .leading){
                                    Text(car.submarca.capitalized)
                                        .bold()
                                        .font(.system(size: 22))
                                    Text(String(car.modelo))
                                        .padding(.bottom, 5)
                                    
                                    Text("$\(String(format: "%.2f", car.precio))")
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Available cars")
            
        }
        
    }
    
    func loadData() {
        
        let carsManager = CarsManager.shared
        
        carsManager.getCars(){ result in
            DispatchQueue.main.async {
                self.dataResult = result
            }
        }
    }
}

/*struct CarsView_Previews: PreviewProvider {
    static var previews: some View {
        CarsView()
    }
}
*/
