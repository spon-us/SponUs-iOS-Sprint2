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
            case let .failure(error):
                return
            }
        }
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        let signUpDetails = SignUpRequest(email: email, password: password, name: name, organizationType: organizationType)
        provider.request(.postSignUp(signUpDetails: signUpDetails)) { result in
            switch result {
            case let .success(response):
                completion(true)
            case let .failure(error):
                completion(false)
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
