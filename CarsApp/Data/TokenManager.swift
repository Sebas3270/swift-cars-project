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
    private let emailKey = "Email"
    private let passwordKey = "Password"

    var authToken: String? {
        get {
            return userDefaults.string(forKey: tokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: tokenKey)
        }
    }
    
    var email: String? {
        get {
            return userDefaults.string(forKey: emailKey)
        }
        set {
            userDefaults.set(newValue, forKey: emailKey)
        }
    }
    
    var password: String? {
        get {
            return userDefaults.string(forKey: passwordKey)
        }
        set {
            userDefaults.set(newValue, forKey: passwordKey)
        }
    }

    func saveData(token: String, email: String, password: String) {
        authToken = token
        self.email = email
        self.password = password
    }

    func removeToken() {
        userDefaults.removeObject(forKey: tokenKey)
        userDefaults.removeObject(forKey: emailKey)
        userDefaults.removeObject(forKey: passwordKey)
    }
}
