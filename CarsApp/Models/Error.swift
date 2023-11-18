//
//  Error.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 16/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
}
