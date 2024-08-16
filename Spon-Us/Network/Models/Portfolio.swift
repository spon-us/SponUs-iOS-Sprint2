//
//  Portfolio.swift
//  Spon-Us
//
//  Created by 박현수 on 8/17/24.
//

import Foundation

struct GetPortfolioResponse: Codable {
    let statusCode: String
    let message: String
    let content: GetPortfolioContent
}

struct GetPortfolioContent: Codable {
    let content: [PortfolioModel]
    let pageable: Pageable
    let totalPages: Int
    let totalElements: Int
    let last: Bool
    let size: Int
    let number: Int
    let sort: PortfolioSort
    let numberOfElements: Int
    let first: Bool
    let empty: Bool
}

struct PortfolioModel: Codable {
    let portfolioId: Int
    let clubId: Int
    let startDate: String
    let endDate: String
    let description: String
    let portfolioImageGetResponses: [PortfolioImageGetResponse]
}

struct PortfolioImageGetResponse: Codable {
    let portfolioImageId: Int
    let url: String
    let order: Int
}

struct Pageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: PortfolioSort
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}

struct PortfolioSort: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}
