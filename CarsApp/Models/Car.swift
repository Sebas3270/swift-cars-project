//
//  Car.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 10/11/23.
//

import Foundation

import Foundation

// MARK: - CarResponse
struct CarsResponse: Codable {
    let message: String
    let result: [Car]
}

// MARK: - Result
struct Car: Codable, Identifiable {
    let id: Int
    let serie, color: String
    let cilindros, idMarca: Int
    let submarca: String
    let modelo, puertas: Int
    let precio: Double
    let idSegmento: Int
    let imagen: String
    let estatus: Int
    let fechaVenta, fechaCreacion, fechaModificacion: String?

    enum CodingKeys: String, CodingKey {
        case id, serie, color, cilindros
        case idMarca = "id_marca"
        case submarca, modelo, puertas, precio
        case idSegmento = "id_segmento"
        case fechaVenta = "fecha_venta"
        case imagen, estatus
        case fechaCreacion = "fecha_creacion"
        case fechaModificacion = "fecha_modificacion"
    }
}


// MARK: - PurchasedCarResponse
struct PurchasedCarResponse: Codable {
    let message: String
    var result: [PurchasedCar]
}

// MARK: - Result
struct PurchasedCar: Codable, Identifiable {
    let id: Int
    let serie: String?
    let autoID: Int?
    let color: String?
    let cilindros: Int?
    let submarca: String?
    let modelo: Int?
    let precio: Double?
    let fechaVenta: String?
    let imagen: String?
    let compradorID: Int

    enum CodingKeys: String, CodingKey {
        case id, serie
        case autoID = "auto_id"
        case color, cilindros, submarca, modelo, precio
        case fechaVenta = "fecha_venta"
        case imagen
        case compradorID = "comprador_id"
    }
}


struct PurchaseResponse: Codable {
    let message: String
    let data: PurchaseData
}

// MARK: - DataClass
struct PurchaseData: Codable {
    let id, compradorID, autoID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case compradorID = "comprador_id"
        case autoID = "auto_id"
    }
}
