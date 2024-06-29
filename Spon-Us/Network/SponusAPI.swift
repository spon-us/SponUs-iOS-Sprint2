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
    case getBookmark(sort: BookmarkTargetType)
    case getSearch(keyword: String)
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
        case .getBookmark:
            return "/api/v2/organizations/bookmarked"
        case .getSearch:
            return "/api/v2/organizations/search"
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
        case .getBookmark:
            return .get
        case .getSearch:
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
        case .getBookmark:
            return Data()
        case .getSearch:
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
        case let .getBookmark(sort):
            return .requestParameters(parameters: ["sort": sort.rawValue], encoding: URLEncoding.queryString)
        case let .getSearch(keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        }
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        
        // TODO: 로그인 API 달리면 토큰 바꾸기
        let auth = ["Authorization": "Bearer "]
        
        switch self {
        case .getOrganizations:
            return auth
        case .getCompany:
            return auth
        case .getClub:
            return auth
        case .getBookmark:
            return auth
        case .getSearch:
            return auth
        }
    }
}
