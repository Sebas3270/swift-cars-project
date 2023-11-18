//
//  TokenHelper.swift
//  CarsApp
//
//  Created by Sebastián Alvarez on 18/11/23.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()

    private let userDefaults = UserDefaults.standard
    private let tokenKey = "AuthToken"

    var authToken: String? {
        get {
            return userDefaults.string(forKey: tokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: tokenKey)
        }
    }

    func saveTokenFromAPI(token: String) {
        // Assuming the token is included in the TokenResponse structure
        authToken = token
    }

    func removeToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
}
