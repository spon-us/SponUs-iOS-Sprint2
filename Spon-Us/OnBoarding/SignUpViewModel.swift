//
//  SignUpViewModel.swift
//  Spon-Us
//
//  Created by 김수민 on 7/2/24.
//

import Foundation
import Moya

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])

    func postEmail(email: String) {
        provider.request(.postEmail(email: email)) { result in
            switch result {
            case let .success(response):
                if let emailResponse = try? response.map(EmailModel.self) {
                    self.email = emailResponse.content.code
                    print("🚨\(email)")
                } else {
                    print("🚨 로그인 API 파싱 실패 :  Invalid response from server")
                }

            case let .failure(error):
                print("Network request failed: \(error)")
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
