//
//  TokenManager.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()

    private init() { }
    
    var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: "accessToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "accessToken")
        }
    }
    
    var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: "refreshToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refreshToken")
        }
    }
    
    var isAutoLogin: Bool? {
        get {
            UserDefaults.standard.bool(forKey: "isAutoLogin")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isAutoLogin")
        }
    }
    
    var fcmToken: String? {
        get {
            UserDefaults.standard.string(forKey: "fcmToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "fcmToken")
        }
    }
    
    func clearTokens() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.removeObject(forKey: "isAutoLogin")
        UserDefaults.standard.removeObject(forKey: "fcmToken")
    }
    
    // reissue API 붙이기
    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        
    }
    
    // refreshToken 만료됐는지 확인하는 로직 붙이기
    func isRefreshTokenExpired() -> Bool {
        return true
    }
}
