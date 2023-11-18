//
//  CarsData.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 10/11/23.
//

import Foundation

class CarsManager {
    
    static let shared = CarsManager()
    
    func getCars(completion: @escaping (Result<[Car], NetworkError>) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://api.vehiculos.alphadev.io/v1/get/autos")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
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
                let carResponse : CarsResponse = try JSONDecoder().decode(CarsResponse.self, from: data)
                completion(.success(carResponse.result))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        
        
    }
    
}
