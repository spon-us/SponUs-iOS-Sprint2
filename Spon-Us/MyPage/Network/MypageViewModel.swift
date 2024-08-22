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
    
    @Published var myOrganizationType: String?
    @Published var clubOrganization: ClubOrganization?
    @Published var companyOrganization: CompanyOrganization?
    
    @Published var clubImageUrl: String = ""
    
    @Published var clubImage: UIImage?
//    
//    
//    @Published var clubName: String = ""
//    
//    
//    @Published var clubDescription: String = ""
//    
//    
//    @Published var clubMemberCount: String = ""
//    
//    
//    @Published var clubTypes: [String] = []
//    
//    
//    @Published var clubProfileStatus: String = ""
    
    
    @Published var clubProfile: ClubProfile?
    
    private let provider = MoyaProvider<SponusAPI>()
    
    init() {
        clubProfile = ClubProfile(name: "", description: "", imageURL: "", memberCount: 0, clubTypes: [], profileStatus: "")
    }
    
    
    func getMyOrganization() {
        provider.request(.getMyOrganization) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    
                    if let responseString = String(data: response.data, encoding: .utf8) {
                                        print("Response as String: \(responseString)")
                                    } else {
                                        print("Failed to convert response to String.")
                                    }
                    
                    if let myOrganizationResponse = try? response.map(MyOrganizationTypeResponse.self) {
                        self.myOrganizationType = myOrganizationResponse.content.organizationType
                        print(self.myOrganizationType)
                        
                        switch self.myOrganizationType {
                        case "CLUB":
                            if let myClubOrganizationResponse = try? response.map(MyOrganizationClubResponse.self) {
                                self.clubOrganization = myClubOrganizationResponse.content
                                print(self.clubOrganization)
                            }
                        case "COMPANY":
                            if let myCompanyOrganizationResponse = try? response.map(MyOrganizationCompanyResponse.self) {
                                self.companyOrganization = myCompanyOrganizationResponse.content
                                print(self.companyOrganization)
                            }
                        default:
                            print("알수없는 조직 타입")
                        }
                    }
                    else {
                        print("조직타입 매핑 실패")
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
        
        // 타임스탬프 기반 파일 이름 생성
        let timestamp = Int(Date().timeIntervalSince1970)
        let uniqueFileName = "image_\(timestamp).jpg"
        
        provider.request(.postProfileImage(image: UIImage, fileName: uniqueFileName)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if let responseString = String(data: response.data, encoding: .utf8) {
                        print("Response Data: \(responseString)")
                        print("postProfileImage네트워크 요청 성공🚨")
                    }
                    
                    if let postImageResponse = try? response.map(PostImageResponse.self) {
                        self.clubProfile?.imageURL = postImageResponse.content.imageUrl
                        print(self.clubProfile)
                        print("postProfileImage매핑 성공🚨")
                    }
                    else {
                        print("postProfileImage매핑 실패🚨")
                    }
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
//    func checkClubImageTabDisabledCondition() {
//        if clubImage == nil {
//            print(true)
//            clubImageTabDisabledCondition = true
//        }
//        else {
//            print(false)
//            clubImageTabDisabledCondition = false
//        }
//    }
//    
//    func checkClubNameTabDisabledCondition() {
//        if clubName.count == 0 || clubName.count > clubNameLimitTextCount {
//            print(true)
//            clubNameTabDisabledCondition = true
//        }
//        else {
//            print(false)
//            clubNameTabDisabledCondition = false
//        }
//    }
//    
//    func checkClubDescriptionTabDisabledCondition() {
//        if clubDescription.count == 0 || clubDescription.count > clubDescriptionLimitTextCount {
//            print(true)
//            clubDescriptionTabDisabledCondition = true
//        }
//        else {
//            print(false)
//            clubDescriptionTabDisabledCondition = false
//        }
//    }
//    
//    func checkClubMemberTabDisabledCondition() {
//        if let numberValue = Int(clubMemberCount), numberValue > 0 {
//            print(false)
//            clubMemberTabDisabledCondition = false
//        }
//        else {
//            print(true)
//            clubMemberTabDisabledCondition = true
//        }
//    }
//    
//    func checkClubTypesTabDisabledCondition() {
//        if clubTypes.count > 0 && clubTypes.count <= 2 {
//            print(false)
//            clubTypesTabDisabledCondition = false
//        }
//        else {
//            print(true)
//            clubTypesTabDisabledCondition = true
//        }
//    }
//    
//    func checkPatchClubProfileDisabledCondition() {
//        if clubImageTabDisabledCondition == false && clubNameTabDisabledCondition == false && clubDescriptionTabDisabledCondition == false && clubMemberTabDisabledCondition == false && clubTypesTabDisabledCondition == false {
//            patchClubProfileDisabledCondition = false
//        }
//        else {
//            patchClubProfileDisabledCondition = true
//        }
//    }
    
}
