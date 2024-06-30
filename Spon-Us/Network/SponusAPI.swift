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
    case getKeyword
    case postKeyword(keyword: String)
    case deleteKeyword(keyword: String)
    case deleteSearch
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
        case .getKeyword:
            return "/api/v2/organizations/search/keywords"
        case .postKeyword:
            return "/api/v2/organizations/search/keywords"
        case .deleteKeyword:
            return "/api/v2/organizations/search/keywords"
        case .deleteSearch:
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
        case .getKeyword:
            return .get
        case .postKeyword:
            return .post
        case .deleteKeyword:
            return .delete
        case .deleteSearch:
            return .delete
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
        case .getKeyword:
            return Data()
        case .postKeyword:
            return Data()
        case .deleteKeyword:
            return Data()
        case .deleteSearch:
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
        case .getKeyword:
            return .requestPlain
        case let .postKeyword(keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: JSONEncoding.default)
        case let .deleteKeyword(keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: JSONEncoding.default)
        case .deleteSearch:
            return .requestPlain
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
        case .getKeyword:
            return auth
        case .postKeyword:
            return auth
        case .deleteKeyword:
            return auth
        case .deleteSearch:
            return auth
        }
    }
}
