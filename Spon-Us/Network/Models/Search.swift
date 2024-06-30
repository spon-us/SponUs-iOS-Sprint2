//
//  Search.swift
//  Spon-Us
//
//  Created by KimYuBin on 6/29/24.
//

import Foundation

struct SearchResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: SearchContent
}

struct SearchContent: Codable {
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
    let content: [SearchModel]
}

struct SearchModel: Codable {
    let id: Int
    let name: String
    let imageUrl: String?
    let organizationType: String
}
