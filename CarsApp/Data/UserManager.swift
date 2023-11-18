//
//  UserData.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    var isLogged: Bool = false
    var user: User? = nil
    private let tokenManager = TokenManager.shared
    
    init() {
        if tokenManager.authToken != nil {
            isLogged = true
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping (Bool) -> Void){
        var request = URLRequest(url: URL(string: "https://api.vehiculos.alphadev.io/v1/comprador/login")!)
        let requestBody = try? JSONSerialization.data(withJSONObject: ["correo": email, "contra":password])
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false)
                return
            }
            
            
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                let logInResponse : LogInResponse = try JSONDecoder().decode(LogInResponse.self, from: data)
                self.user = logInResponse.result
                self.tokenManager.saveTokenFromAPI(token: self.user!.token)
                completion(true)
            } catch {
                completion(false)
            }
        }
        
        task.resume()
        
    }
    
    
    func getPurchasedCars(completion: @escaping (Result<[PurchasedCar], NetworkError>) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://api.vehiculos.alphadev.io/v1/compra")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(self.tokenManager.authToken!, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidData))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            
            do {
                var carResponse : PurchasedCarResponse = try JSONDecoder().decode(PurchasedCarResponse.self, from: data)
                carResponse.result = carResponse.result.filter { $0.serie != nil }
                completion(.success(carResponse.result))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        
        
    }
    
    
}
