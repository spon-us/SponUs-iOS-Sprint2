//
//  LoginViewModel.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import Foundation
import Moya

class LoginViewModel: ObservableObject {
    @Published var loginSuccess: Bool = false
    
    func logout() {
        loginSuccess = false
        TokenManager.shared.clearTokens()
    }

    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    func login(email: String, password: String, completion: @escaping (String) -> Void) {
        let loginDetails = LoginRequest(email: email, password: password, fcmToken: "fcmfcmfcm")
        provider.request(.postLogin(loginDetails: loginDetails)) { result in
            switch result {
            case let .success(response):
                if let loginResponse = try? response.statusCode == 200 {
                    if let loginResponse = try? response.map(LoginResponse.self) {
                        TokenManager.shared.accessToken = loginResponse.content.accessToken
                        TokenManager.shared.refreshToken = loginResponse.content.refreshToken
                        completion("success")
                        print("🚨로그인 API 성공")
                        print(" access:\(loginResponse.content.accessToken)")
                        print(" refresh:\(loginResponse.content.refreshToken)")
                    } else {
                        print("🚨로그인 API 200 매핑 실패")
                    }
                } else {
                    if let errorResponse = try? response.map(ErrorResponse.self) {
                        completion("\(errorResponse.message)")
                        print("🚨로그인 API 404에러")
                    }
                    print("🚨로그인 API 404에러 매핑 실패")
                }
            case .failure:
                completion("failure")
                print("🚨 로그인 API 실패")
            }
        }
    }
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
    let fcmToken: String
}

struct LoginResponse: Decodable {
    let statusCode: String
    let message: String
    let content: LoginContent
}

struct LoginContent: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct ErrorResponse: Decodable {
    let statusCode: String
    let message: String
    let content: String
}
