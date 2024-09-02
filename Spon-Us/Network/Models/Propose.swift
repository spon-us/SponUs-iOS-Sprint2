//
//  Propose.swift
//  Spon-Us
//
//  Created by 박현수 on 9/2/24.
//

import Foundation

struct ProposeResponse: Codable {
    let statusCode: String
    let message: String
    let content: ProposeContent
}

struct ProposeContent: Codable {
    let id: Int
    let organizationId: Int
    let target: Int
}

struct ProposeExceptionResponse: Codable {
    let statusCode: String
    let message: String
}
