//
//  MypageViewModel.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import Foundation
import UIKit


class WriteClubProfileViewModel: ObservableObject {
    
    @Published var clubProfile: ClubProfile?
    
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
    
}
