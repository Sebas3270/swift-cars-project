//
//  User.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import Foundation

// MARK: - LogInResponse
struct LogInResponse: Codable {
    let message, status: String
    let result: User
}

// MARK: - Result
struct User: Codable {
    let id: Int
    let nombre, apellidos, telefono, correo: String
    let contra, llave: String
    let fechaModificacion: String?
    let fechaCreacion, token: String

    enum CodingKeys: String, CodingKey {
        case id, nombre, apellidos, telefono, correo, contra, llave
        case fechaModificacion = "fecha_modificacion"
        case fechaCreacion = "fecha_creacion"
        case token
    }
}
