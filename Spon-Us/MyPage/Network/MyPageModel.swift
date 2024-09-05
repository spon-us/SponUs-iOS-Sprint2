//
//  MyPageModel.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import Foundation
import UIKit

//struct ClubProfile {
//    var image: UIImage?
//    var name: String
//    var introduce: String
//    var member: Int
//    var link: Link?
//    var fields: [String]
//}

struct Link {
    var instagram: String
    var facebook: String
    var website: String
}

struct Portfolio {
    var projectName: String
    var activityDetail: String
//    var date
    var multiImage: [UIImage]
}


//struct MyOrganizationResponse: Codable {
//    let statusCode: String
//    let message: String
//    let content: String
//}

struct MyOrganizationTypeResponse: Codable {
    let statusCode: String
    let message: String
    let content: MyOrganization
}

struct MyOrganizationClubResponse: Codable {
    let statusCode: String
    let message: String
    let content: ClubOrganization
}

struct MyOrganizationCompanyResponse: Codable {
    let statusCode: String
    let message: String
    let content: CompanyOrganization
}

struct MyOrganization: Codable {
    let id: Int
//    let name: String
//    let email: String
//    let description: String?
//    let imageURL: String?
//    let bookmarkCount: Int
//    let viewCount: Int
    let organizationType: String
//    let profileStatus: String
//    let role: String
//    let memberCount: Int
//    let links
//    let clubTypes
}


// 클럽 모델
struct ClubOrganization: Codable {
    let id: Int
    let name: String
    let email: String
    let description: String?
    let imageUrl: String?
    let bookmarkCount: Int
    let viewCount: Int
    let profileStatus: String
    let role: String
    let memberCount: Int
    let links: [String]
    let clubTypes: [String]
}

// 기업 모델
struct CompanyOrganization: Codable {
    let id: Int
    let name: String
    let email: String
    let description: String?
    let imageUrl: String?
    let bookmarkCount: Int
    let viewCount: Int
    let profileStatus: String
    let role: String
    let companyTypes: [String]
    let collaborationTypes: [String]
    let sponsorshipContent: String?
}





struct ClubProfile: Codable {
    var name: String
    var description: String
    var imageURL: String
    var memberCount: Int
    var clubTypes: [String]
    var profileStatus: String
}


struct PostImageResponse: Codable {
    let statusCode: String
    let message: String
    let content: ImageUrl
}

struct ImageUrl: Codable {
    let imageUrl: String
}
