//
//  Company.swift
//  Spon-Us
//
//  Created by 박현수 on 6/25/24.
//

import Foundation

struct CompanyResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: CompanyModel
}

struct CompanyModel: Codable {
    let id: Int
    var name: String
    var email: String?
    var description: String?
    var imageUrl: String?
    var bookmarkCount: Int
    var viewCount: Int
    var organizationType: String
    var profileStatus: String
    var role: String
    var companyType: String
    var collaborationType: String
    var sponsorshipContent: String
}
