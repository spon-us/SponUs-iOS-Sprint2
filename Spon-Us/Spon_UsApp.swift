//
//  Spon_UsApp.swift
//  Spon-Us
//
//  Created by 박현수 on 5/4/24.
//

import SwiftUI
import UIKit


@main
struct Spon_UsApp: App {
    @StateObject var vm = LoginViewModel()
    
    var body: some Scene {
        WindowGroup() {
//            if (vm.loginSuccess || TokenManager.shared.isAutoLogin ?? false) && !TokenManager.shared.isRefreshTokenExpired() {
                ContentView()
//            } else {
//                OnBoardingView()
//            }
        }.environmentObject(vm)
    }
}
