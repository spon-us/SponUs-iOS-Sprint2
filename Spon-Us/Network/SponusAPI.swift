//
//  SponusAPI.swift
//  Spon-Us
//
//  Created by 박현수 on 6/23/24.
//

import Foundation
import Moya

enum SponusAPI {
    case getOrganizations(organizationType: String)
    case getCompany(companyId: Int)
    case getClub(clubId: Int)
}

extension SponusAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.sponus.co.kr")!
    }
    
    var path: String {
        switch self {
        case .getOrganizations:
            return "/api/v2/organizations"
        case let .getCompany(companyId):
            return "/api/v2/companies/\(companyId)"
        case let .getClub(clubId):
            return "/api/v2/clubs/\(clubId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getOrganizations:
            return .get
        case .getCompany:
            return .get
        case .getClub:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getOrganizations:
            return Data()
        case .getCompany:
            return Data()
        case .getClub:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case let .getOrganizations(organizationType):
            let param = [
                "organizationType": organizationType
            ]
            return .requestParameters(
                parameters: param,
                encoding: URLEncoding.default
            )
        case .getCompany:
            return .requestPlain
        case .getClub:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        
        // TODO: 로그인 API 달리면 토큰 바꾸기
        let auth = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZW1haWwiOiJzdHJpbmciLCJhdXRoIjoiQ0xVQiIsImlhdCI6MTcxOTQ1MTM0MywiZXhwIjoxNzIwNDUxMzQzfQ.uO0O6k7Bsrjkdg9-jIYFAYJqq9-6ydJstFjawr-jLgs"]
        
        switch self {
        case .getOrganizations:
            return auth
        case .getCompany:
            return auth
        case .getClub:
            return auth
        }
    }
}

