//
//  AuthPlugin.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import Foundation
import Moya

final class AuthPlugin: PluginType {
    var onRetrySuccess: (() -> Void)?
    var onRetryFail: (() -> Void)?
    
    private var originalRequest: URLRequest?
    
    func willSend(_ request: RequestType, target: TargetType) {
        originalRequest = request.request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if response.statusCode == 401 {
                handle401Error(for: response)
            }
        case .failure(let error):
            if error.response?.statusCode == 401 {
                handle401Error(for: error.response!)
            } else {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    private func handle401Error(for response: Response) {
        // 토큰 재발급 시도
        TokenManager.shared.refreshAccessToken { success in
            if success {
                // 원래 요청 재시도
                guard var newRequest = self.originalRequest else {
                    print("🤢 원래 요청을 생성할 수 없습니다.")
                    self.onRetryFail?()
                    return
                }
                if let newToken = TokenManager.shared.accessToken {
                    newRequest.setValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
                }
                let task = URLSession.shared.dataTask(with: newRequest) { data, response, error in
                    if let error = error {
                        print("🤢 재시도 요청 실패: \(error)")
                        DispatchQueue.main.async {
                            self.onRetryFail?()
                        }
                    } else if let response = response as? HTTPURLResponse {
                        if (200...299).contains(response.statusCode) {
                            print("😊 재시도 요청 성공: \(response.statusCode)")
                            DispatchQueue.main.async {
                                self.onRetrySuccess?()
                            }
                        } else {
                            print("🤢 재시도 요청 실패: \(response.statusCode)")
                            DispatchQueue.main.async {
                                self.onRetryFail?()
                            }
                        }
                    } else {
                        print("🤢 알 수 없는 오류 발생")
                        DispatchQueue.main.async {
                            self.onRetryFail?()
                        }
                    }
                }
                task.resume()
            } else {
                print("🤢 refreshToken 만료!!")
                DispatchQueue.main.async {
                    self.onRetryFail?()
                }
            }
        }
    }
}
