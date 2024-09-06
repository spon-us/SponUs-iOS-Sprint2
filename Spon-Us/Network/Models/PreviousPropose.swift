//
//  PreviousPropose.swift
//  Spon-Us
//
//  Created by KimYuBin on 9/6/24.
//

import Foundation

struct PreviousPropose: Codable {
    let statusCode: String
    let message: String
    let content: PreviousProposeContent
}

struct PreviousProposeContent: Codable {
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
    let content: [PreviousProposeModel]
}

struct PreviousProposeModel: Codable {
    let id: Int
    let organizationId: Int
    let target: Int
    let targetName: String
    let targetImageUrl: String?
    let status: String
    let createdAt: String
}
