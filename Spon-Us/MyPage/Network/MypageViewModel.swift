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
    
    @Published var clubProfile: ClubProfile?
    
    private let provider = MoyaProvider<SponusAPI>()
    
    init() {
            self.clubProfile = ClubProfile(image: nil, name: "", introduce: "", member: 0, link: nil, fields: [])
        }
    
    func addClubProfileImage(image: UIImage) {
        clubProfile?.image = image
    }
    
    func addClubProfileName(name: String) {
        clubProfile?.name = name
    }
    
    func addClubProfileIntroduce(introduce: String) {
        clubProfile?.introduce = introduce
    }
    
    func addClubProfileMember(member: Int) {
        clubProfile?.member = member
    }
    
    func addClubProfileLink(link: Link) {
        clubProfile?.link = link
    }
    
    func addClubProfileField(fields: [String]) {
            clubProfile?.fields = fields
        }
    
    func getMyOrganization() {
        provider.request(.getMyOrganization) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if let myOrganizationResponse = try? response.map(MyOrganizationResponse.self) {
                        self.myOrganization = myOrganizationResponse.content
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
    
    
    
}
