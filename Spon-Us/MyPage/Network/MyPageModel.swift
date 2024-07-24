//
//  MyPageModel.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import Foundation
import UIKit

struct ClubProfile {
    var image: UIImage?
    var name: String
    var introduce: String
    var member: Int
    var link: Link?
    var fields: [String]
}

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



struct MyOrganizationResponse: Codable {
    let statusCode: String
    let message: String
    let content: MyOrganization
}

struct MyOrganization: Codable {
    let id: Int
    let name: String
    let email: String
//    let description: String?
//    let imageURL: String
    let bookmarkCount: Int
    let viewCount: Int
    let organizationType: String
    let profileStatus: String
    let role: String
    let memberCount: Int
//    let links
//    let clubTypes
}
