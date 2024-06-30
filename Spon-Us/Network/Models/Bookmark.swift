//
//  Bookmark.swift
//  Spon-Us
//
//  Created by KimYuBin on 6/28/24.
//

import Foundation

struct BookmarkResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: [BookmarkModel]
}

struct BookmarkModel: Codable {
    let id: Int
    let organizationId: Int
    let target: Int
    let name: String
    let imageUrl: String?
    let targetType: BookmarkTargetType
    let createdAt: String
}

enum BookmarkTargetType: String, Codable {
    case recent = "RECENT"
    case company = "COMPANY"
    case club = "CLUB"
}
