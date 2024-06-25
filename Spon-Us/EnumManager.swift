//
//  EnumManager.swift
//  Spon-Us
//
//  Created by 박현수 on 5/14/24.
//

import Foundation
import SwiftUI

enum CompanyClubSelection: String {
    case club = "CLUB"
    case company = "COMPANY"
}

enum CompanyCategory: String, CaseIterable {
    case all = "전체"
    case food = "식품"
    case health = "건강"
    case lifestyle = "생활"
    case education = "교육"
    case beauty = "뷰티"
    case others = "기타"
}

enum ClubCategory: String, CaseIterable {
    case all = "전체"
    case planningAndIdeas = "기획/아이디어"
    case advertisingAndMarketing = "광고/마케팅"
    case design = "디자인"
    case photographyAndVideo = "사진/영상"
    case iTAndSoftware = "IT/소프트웨어"
    case others = "기타"
}

enum CoworkCategory: String {
    case linkedProject = "연계프로젝트"
    case partnership = "제휴"
    case sponsorship = "협찬"
}

enum ProfileStatus {
    case available, exceeded, unavailable
}
