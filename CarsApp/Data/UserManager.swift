//
//  UserData.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import Foundation
import SwiftUI

class UserManager: ObservableObject {
    
    static let shared = UserManager()
    
    @Published var isLogged: Bool = false
    @Published var user: User? = nil
    @Published var purchasedCars: [PurchasedCar] = []
    private let tokenManager = TokenManager.shared
    
    init() {
        if tokenManager.authToken != nil {
            logIn(email: tokenManager.email!, password: tokenManager.password!){ result in
                DispatchQueue.main.async {
                    self.isLogged = result
                }
            }
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
                DispatchQueue.main.async {
                    self.user = logInResponse.result
                    self.tokenManager.saveData(
                        token: self.user!.token,
                        email: self.user!.correo,
                        password: self.user!.contra
                    )
                    self.isLogged = true
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
        
        task.resume()
        
    }
    
    func register(name: String, lastName: String, phone: String,email: String, password: String, completion: @escaping (Bool) -> Void){
        var request = URLRequest(url: URL(string: "https://api.vehiculos.alphadev.io/v1/comprador/signup")!)
        let requestBody = try? JSONSerialization.data(withJSONObject: ["correo": email, "contra":password, "telefono": phone, "nombre": name, "apellidos": lastName])
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
                let _ = try JSONDecoder().decode(RegisterResponse.self, from: data)
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
        request.addValue(self.tokenManager.authToken ?? "", forHTTPHeaderField: "Authorization")
        
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
            
            do {
                var carResponse : PurchasedCarResponse = try JSONDecoder().decode(PurchasedCarResponse.self, from: data)
                DispatchQueue.main.async {
                    
                    carResponse.result = carResponse.result.filter { $0.serie != nil }
                    self.purchasedCars = carResponse.result
                    completion(.success(carResponse.result))
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        
        
    }
    
    func purchaseCar(carId: Int, completion: @escaping (Bool) -> Void){
        var request = URLRequest(url: URL(string: "https://api.vehiculos.alphadev.io/v1/compra")!)
        let requestBody = try? JSONSerialization.data(withJSONObject: ["auto_id": String(carId)])
        request.addValue(self.tokenManager.authToken ?? "", forHTTPHeaderField: "Authorization")
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
            
            /*do {
                let _ = try JSONDecoder().decode(PurchaseResponse.self, from: data)
                completion(true)
            } catch {
                completion(false)
            }*/
            
            completion(true)
        }
        
        task.resume()
        
    }
    
    func logOut(){
        tokenManager.removeToken()
        isLogged = false
    }
    
    
}
