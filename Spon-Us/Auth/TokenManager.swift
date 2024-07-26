//
//  TokenManager.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import Foundation
import Moya

class TokenManager {
    static let shared = TokenManager()
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
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
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = refreshToken else {
            completion(false)
            return
        }
        
        provider.request(.getReissue(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 400 {
                    print("🚨토큰 재발급 네트워크 실패: 상태 코드 400 -> refresh 토큰 만료")
                    completion(false)
                    return
                }
                do {
                    if let loginResponse = try? response.map(LoginResponse.self) {
                        self.accessToken = loginResponse.content.accessToken
                        self.refreshToken = loginResponse.content.refreshToken
                        completion(true)
                        print("🚨reissue API 성공")
                        print(" access:\(loginResponse.content.accessToken)")
                        print(" refresh:\(loginResponse.content.refreshToken)")
                    }
                } catch {
                    print("🚨reissue API 네트워크 매핑 실패")
                    completion(false)
                }
            case .failure(let error):
                print("🚨reissue API 네트워크 실패")
                print("refreshToken:\(refreshToken)")
                completion(false)
            }
        }
    }
    
    // refreshToken 만료됐는지 확인하는 로직 붙이기
    func isRefreshTokenExpired() -> Bool {
        return false
    }
}
