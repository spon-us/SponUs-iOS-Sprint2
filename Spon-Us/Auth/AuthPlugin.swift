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
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if response.statusCode == 401 {
                // 토큰이 만료된 경우 -> Reissue
                TokenManager.shared.refreshAccessToken { success in
                    if success {
                        // 원래 요청 재시도.
                        guard var newRequest = response.request else {
                            print("🤢 원래 요청을 생성할 수 없습니다.")
                            return
                        }
                        if let newToken = TokenManager.shared.accessToken {
                            newRequest.setValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
                        }
                        let task = URLSession.shared.dataTask(with: newRequest) { data, response, error in
                            if let error = error {
                                print("🤢 재시도 요청 실패: \(error)")
                            } else if let response = response as? HTTPURLResponse {
                                if (200...299).contains(response.statusCode) {
                                    print("😊 재시도 요청 성공: \(response.statusCode)")
                                    DispatchQueue.main.async {
                                        self.onRetrySuccess?()
                                    }
                                } else {
                                    print("🤢 재시도 요청 실패: \(response.statusCode)")
                                }
                            } else {
                                print("🤢 알 수 없는 오류 발생")
                            }
                        }
                        task.resume()
                    } else {
                        print("🤢 refreshToken 만료!!")
                    }
                }
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}


// MARK: Plugin 사용법!
//let authPlugin = AuthPlugin()
// onRetrySuccess -> 작동 시킨 후 UI적으로 재시동시킬것
//authPlugin.onRetrySuccess = { [weak self] in
//    self?.fetchReservationAPI(for: self?.selectedDate ?? Date())
//    self?.fetchWeekReservationAPI(for: self?.selectedDate ?? Date())
//}
//self.provider = MoyaProvider<NewReservationAPI>(plugins: [authPlugin])
