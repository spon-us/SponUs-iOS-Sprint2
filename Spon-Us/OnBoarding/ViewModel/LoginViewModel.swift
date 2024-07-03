//
//  LoginViewModel.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginSuccess: Bool = false
    
    func logout() {
        loginSuccess = false
        TokenManager.shared.clearTokens()
    }
}
