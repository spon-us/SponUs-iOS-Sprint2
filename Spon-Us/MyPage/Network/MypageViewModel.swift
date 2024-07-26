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
    
    @Published var clubName: String = ""
    
    
    @Published var clubDescription: String = ""
    @Published var clubMemberCount: String = ""
    @Published var clubTypes: [String] = []
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
//                    if let myOrganizationResponse = try? response.map(MyOrganizationResponse.self) {
//                        self.myOrganization = myOrganizationResponse.content
//                        self.clubName = self.myOrganization?.name ?? "name"
//                        print("patchClubProfile매핑 성공🚨")
//                    }
//                    else {
//                        print("patchClubProfile매핑 실패🚨")
//                    }
                case .failure:
                    print("patchClubProfile네트워크 요청 실패🚨")
                }
            }
        }
    }
    
    
    
}
