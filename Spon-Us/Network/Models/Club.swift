//
//  Club.swift
//  Spon-Us
//
//  Created by 박현수 on 6/25/24.
//

import Foundation

struct ClubResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: ClubModel
}

struct ClubModel: Codable {
    let id: Int
    let name: String
    let email: String
    let description: String?
    let imageUrl: String?
    let bookmarkCount: Int
    let viewCount: Int
    let organizationType: String
    let profileStatus: String
    let role: String
    let memberCount: Int
    let clubType: String
}
