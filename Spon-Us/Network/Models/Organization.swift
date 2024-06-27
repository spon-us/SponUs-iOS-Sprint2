//
//  GetOrganization.swift
//  Spon-Us
//
//  Created by 박현수 on 6/25/24.
//

import Foundation

struct OrganizationResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: OrganizationDataModel
}

struct OrganizationDataModel: Codable {
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
    let content: [OrganizationModel]
}

struct OrganizationModel: Codable {
    let id: Int
    var name: String
    var email: String
    var description: String?
    var imageUrl: String?
    var bookmarkCount: Int
    var viewCount: Int
    var organizationType: String
    var subType: String
    var isBookmarked: Bool
}
