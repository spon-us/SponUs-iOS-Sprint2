//
//  SponusAPI.swift
//  Spon-Us
//
//  Created by 박현수 on 6/23/24.
//

import Foundation
import Moya

enum SponusAPI {
    case getOrganizations(page: Int, size: Int, organizationType: String)
}

extension SponusAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.sponus.co.kr")!
    }
    
    var path: String {
        switch self {
        case .getOrganizations:
            return "/api/v2/organizations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getOrganizations:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getOrganizations:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case let .getOrganizations(page, size, organizationType):
            let param = [
                "page": "\(page)",
                "size": "\(size)",
                "organizationType": organizationType
            ]
            return .requestParameters(
                parameters: param,
                encoding: URLEncoding.default
            )
        }
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        switch self {
            // TODO: 로그인 API 달리면 토큰 바꾸기
        case .getOrganizations:
            return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZW1haWwiOiJzdHJpbmciLCJhdXRoIjoiQ0xVQiIsImlhdCI6MTcxOTMwNTQ4NiwiZXhwIjoxNzIwMzA1NDg2fQ.C8YOjssU_KZHt0KdqfluhI2o-9IVLpEOEz18kKjIPZY"]
        }
    }
}
