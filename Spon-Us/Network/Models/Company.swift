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
    let name: String
    let email: String?
    let description: String?
    let imageUrl: String?
    let bookmarkCount: Int
    let viewCount: Int
    let organizationType: String
    let profileStatus: String
    let role: String
    let companyType: String
    let collaborationType: String
    let sponsorshipContent: String
}
