//
//  SignUpViewModel.swift
//  Spon-Us
//
//  Created by 김수민 on 7/2/24.
//

import Foundation
import Moya

class SignUpViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var organizationType: String = ""

    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])

    func postEmail(email: String) {
        provider.request(.postEmail(email: email)) { result in
            switch result {
            case let .success(response):
                if let emailResponse = try? response.map(EmailModel.self) {
                    self.code = emailResponse.content.code
                }
            case .failure:
                return
            }
        }
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        let signUpDetails = SignUpRequest(email: email, password: password, name: name, organizationType: organizationType)
        provider.request(.postSignUp(signUpDetails: signUpDetails)) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func isValidEmail(email: String, completion: @escaping (String?) -> Void) {
        provider.request(.getVerifyEmail(email: email)) { result in
            switch result {
            case .success(let response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any],
                       let content = json["content"] as? [String: Any],
                       let exist = content["exist"] as? String {
                        DispatchQueue.main.async {
                            completion(exist)
                        }
                    }
                } catch let error {
                    print("🚨getVerifyEmail API 파싱 에러 \(error)")
                }
            case .failure(let error):
                print("🚨getVerifyEmail API 서버 에러 \(error)")
            }
        }
    }
}

struct EmailModel: Decodable {
    let statusCode: String
    let message: String
    let content: EmailModelContent
}

struct EmailModelContent: Decodable {
    let email: String
    let code: String
}

struct SignUpRequest: Encodable {
    let email: String
    let password: String
    let name: String
    let organizationType: String
}
