//
//  Spon_UsApp.swift
//  Spon-Us
//
//  Created by 박현수 on 5/4/24.
//

import SwiftUI
import UIKit

import FirebaseCore
import UserNotifications
import FirebaseMessaging
class AppDelegate: NSObject, UIApplicationDelegate {
    // App이 실행될때 실행되는 매서드
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        //원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // Messaging
        Messaging.messaging().delegate = self

        // PUSH foreground
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // Firebase Messaging 과 APNs 토큰과 연결
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token from the Server ")
        print("Registration Token Info: \(String(describing: fcmToken))")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("Will Present User INFO : \(userInfo)")
        completionHandler([.banner, .sound, .badge])
    }
    
    // 푸시 메시지를 받았을때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Did Receieve User INFO : \(userInfo)")
        completionHandler()
    }
}


@main
struct Spon_UsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var vm = LoginViewModel()
    
    var body: some Scene {
        WindowGroup() {
            if (vm.loginSuccess ||  UserDefaults.standard.bool(forKey: "isAutoLogin")) && !TokenManager.shared.isRefreshTokenExpired() {
                ContentView().onAppear(perform: {
                    print("\(vm.loginSuccess), \(TokenManager.shared.isAutoLogin ?? false), \(!TokenManager.shared.isRefreshTokenExpired())")
                    print("accessToken : \(TokenManager.shared.accessToken)")
                }).environmentObject(vm)
            } else {
                OnBoardingView().onAppear(perform: {
                    print("\(vm.loginSuccess), \(TokenManager.shared.isAutoLogin ?? false), \(!TokenManager.shared.isRefreshTokenExpired())")
                }).environmentObject(vm)
            }
//            WriteCompanyProfileView()
        }/*.environmentObject(vm)*/
            .environmentObject(MypageNavigationPathFinder.shared)
    }
}
