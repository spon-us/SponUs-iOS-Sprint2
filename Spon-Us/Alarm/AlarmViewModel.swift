//
//  AlarmViewModel.swift
//  Spon-Us
//
//  Created by 김수민 on 9/7/24.
//

import Foundation
import Moya

class AlarmViewModel: ObservableObject {
    @Published public var successSendAPI: Bool = false
    @Published public var successReceivedAPI: Bool = false
    
    let provider = MoyaProvider<SponusAPI>()
    
    // MARK: Data
    var sendList: [SendAlarmModel] = []
    var receivedList: [ReceivedAlarmModel] = []
    
    // MARK: Network
    func onAlarmViewAppear() {
        fetchSendAlarm() { success in
            if success {
                self.successSendAPI = true
                self.fetchReceivedAlarm() { success in
                    if success {
                        self.successReceivedAPI = true
                    } else {
                        self.successReceivedAPI = false
                    }
                }
            } else {
                self.successSendAPI = false
            }
        }
    }
    
    func fetchSendAlarm(completion: @escaping (Bool) -> Void) {
        provider.request(.getSendAlarm) { response in
            switch response {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(SendAlarmResponseModel.self, from: response.data)
                    self.sendList = data.content
                    print("sendAPI success")
                    completion(true)
                } catch let error {
                    print("fetch sendAPI decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("sendAPI failure error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func fetchReceivedAlarm(completion: @escaping (Bool) -> Void) {
        provider.request(.getReceivedAlarm) { response in
            switch response {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(ReceivedAlarmResponseModel.self, from: response.data)
                    self.receivedList = data.content
                    print("receiveAPI success")
                    completion(true)
                } catch let error {
                    print("fetch receiveAPI decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("receiveAPI failure error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}

struct SendAlarmResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: [SendAlarmModel]
}

struct SendAlarmModel: Codable {
    let id: Int
    let title: String
    let body: String
    let organizationProfile: String
    let organizationName: String
    let proposeId: Int
    let isRead: Bool
    let createdAt: String // "2024-09-07T09:09:29.409Z"
    let updatedAt: String // "2024-09-07T09:09:29.409Z"
}

struct ReceivedAlarmResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: [ReceivedAlarmModel]
}

struct ReceivedAlarmModel: Codable {
    let id: Int
    let title: String
    let body: String
    let organizationProfile: String
    let organizationName: String
    let proposeId: Int
    let isRead: Bool
    let createdAt: String // "2024-09-07T09:09:29.409Z"
    let updatedAt: String // "2024-09-07T09:09:29.409Z"
}

