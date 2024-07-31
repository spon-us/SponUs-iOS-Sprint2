//
//  MypageViewModel.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import Foundation
import UIKit
import Moya


class MypageViewModel: ObservableObject {
    
    @Published var myOrganization: MyOrganization?
    
    @Published var clubImageUrl: String = ""
    
    @Published var clubImage: UIImage?
    @Published var clubImageTabDisabledCondition: Bool = true
    
    
    @Published var clubName: String = ""
    var clubNameLimitTextCount = 13
    @Published var clubNameTabDisabledCondition: Bool = true
    
    
    @Published var clubDescription: String = ""
    var clubDescriptionLimitTextCount = 300
    @Published var clubDescriptionTabDisabledCondition: Bool = true
    
    
    @Published var clubMemberCount: String = ""
//    var clubMemberCountLimitTextCount: String = ""
    @Published var clubMemberTabDisabledCondition: Bool = true
    
    
    @Published var clubTypes: [String] = []
    @Published var clubTypesTabDisabledCondition: Bool = true
    
    @Published var patchClubProfileDisabledCondition: Bool = true
    
    
    @Published var clubProfileStatus: String = ""
    
    
    @Published var clubProfile: ClubProfile?
    
    private let provider = MoyaProvider<SponusAPI>()
    
    
    func getMyOrganization() {
        provider.request(.getMyOrganization) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if let myOrganizationResponse = try? response.map(MyOrganizationResponse.self) {
                        self.myOrganization = myOrganizationResponse.content
                        self.clubName = self.myOrganization?.name ?? "name"
                        print("getMyOrganization매핑 성공🚨")
                    }
                    else {
                        print("getMyOrganization매핑 실패🚨")
                    }
                case .failure:
                    print("getMyOrganization네트워크 요청 실패🚨")
                }
            }
        }
    }
    
    func patchClubProfile(clubProfile: ClubProfile) {
        provider.request(.patchMyClubProfile(clubProfile: clubProfile)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    print("patchClubProfile네트워크 요청 성공🚨")
                case .failure:
                    print("patchClubProfile네트워크 요청 실패🚨")
                }
            }
        }
    }
    
    func postProfileImage(UIImage: UIImage) {
        provider.request(.postProfileImage(image: UIImage)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if let responseString = String(data: response.data, encoding: .utf8) {
                        print("Response Data: \(responseString)")
                    }
                    print("postProfileImage네트워크 요청 성공🚨")
                case .failure(let error):
                    
                    if let response = error.response {
                        if let responseString = String(data: response.data, encoding: .utf8) {
                            print("Error Response Data: \(responseString)")
                        }
                    }
                        print("postProfileImage네트워크 요청 실패🚨")
                    }
                }
            }
        }
        
    // api 아닌 함수
    func checkClubImageTabDisabledCondition() {
        if clubImage == nil {
            print(true)
            clubImageTabDisabledCondition = true
        }
        else {
            print(false)
            clubImageTabDisabledCondition = false
        }
    }
    
    func checkClubNameTabDisabledCondition() {
        if clubName.count == 0 || clubName.count > clubNameLimitTextCount {
            print(true)
            clubNameTabDisabledCondition = true
        }
        else {
            print(false)
            clubNameTabDisabledCondition = false
        }
    }
    
    func checkClubDescriptionTabDisabledCondition() {
        if clubDescription.count == 0 || clubDescription.count > clubDescriptionLimitTextCount {
            print(true)
            clubDescriptionTabDisabledCondition = true
        }
        else {
            print(false)
            clubDescriptionTabDisabledCondition = false
        }
    }
    
    func checkClubMemberTabDisabledCondition() {
        if let numberValue = Int(clubMemberCount), numberValue > 0 {
            print(false)
            clubMemberTabDisabledCondition = false
        }
        else {
            print(true)
            clubMemberTabDisabledCondition = true
        }
    }
    
    func checkClubTypesTabDisabledCondition() {
        if clubTypes.count > 0 && clubTypes.count <= 2 {
            print(false)
            clubTypesTabDisabledCondition = false
        }
        else {
            print(true)
            clubTypesTabDisabledCondition = true
        }
    }
    
    func checkPatchClubProfileDisabledCondition() {
        if clubImageTabDisabledCondition == false && clubNameTabDisabledCondition == false && clubDescriptionTabDisabledCondition == false && clubMemberTabDisabledCondition == false && clubTypesTabDisabledCondition == false {
            patchClubProfileDisabledCondition = false
        }
        else {
            patchClubProfileDisabledCondition = true
        }
    }
    
}
