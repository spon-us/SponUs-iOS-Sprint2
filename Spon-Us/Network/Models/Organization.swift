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
    let name: String
    let email: String
    let description: String?
    let imageUrl: String?
    let bookmarkCount: Int
    let viewCount: Int
    let organizationType: String
}
