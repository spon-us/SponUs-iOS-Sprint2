//
//  SponusAPI.swift
//  Spon-Us
//
//  Created by 박현수 on 6/23/24.
//

import Foundation
import Moya
import UIKit

enum SponusAPI {
    case getOrganizations(organizationType: String, page: Int, size: Int)
    case getCompany(companyId: Int)
    case getClub(clubId: Int)
    case getBookmark(sort: BookmarkTargetType)
    case postBookmark(target: Int)
    case getSearch(keyword: String)
    case getKeyword
    case postKeyword(keyword: String)
    case postEmail(email: String)
    case postSignUp(signUpDetails: SignUpRequest)
    case postLogin(loginDetails: LoginRequest)
    case deleteKeyword(keyword: String)
    case deleteSearch
    case getVerifyEmail(email: String)
    case getReissue(refreshToken: String)
    case getMyOrganization
    case patchMyClubProfile(clubProfile: ClubProfile)
    case postProfileImage(image: UIImage, fileName: String)
    case getPortfolios(page: Int, size: Int, clubId: Int)
    case postPropose(target: Int)
    case getProposeSend(page: Int, size: Int)
    case getProposeReceive(page: Int, size: Int)
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
        case .postBookmark:
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
        case .postEmail:
            return "/api/v2/auth/send-code"
        case .postSignUp:
            return "/api/v2/organizations/join"
        case .postLogin:
            return "/api/v2/auth/login"
        case .getVerifyEmail:
            return "/api/v2/auth/verify-email"
        case .getReissue:
            return "/api/v2/auth/reissue"
        case .getMyOrganization:
            return "/api/v2/organizations/me"
        case .patchMyClubProfile:
            return "/api/v2/clubs/me"
        case .postProfileImage:
            return "/api/v2/organizations/me/profileImage"
        case .getPortfolios:
            return "/api/v2/portfolio"
        case .postPropose:
            return "/api/v2/proposes"
        case .getProposeSend:
            return "/api/v2/proposes/send"
        case .getProposeReceive:
            return "/api/v2/proposes/receive"
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
        case .postBookmark:
            return .post
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
        case .postEmail:
            return .get
        case .postSignUp:
            return .post
        case .postLogin:
            return .post
        case .getVerifyEmail:
            return .get
        case .getReissue:
            return .get
        case .getMyOrganization:
            return .get
        case .patchMyClubProfile:
            return .patch
        case .postProfileImage:
            return .post
        case .getPortfolios:
            return .get
        case .postPropose:
            return .post
        case .getProposeSend:
            return .get
        case .getProposeReceive:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .getOrganizations(organizationType, page, size):
            let param = [
                "organizationType": organizationType,
                "page": page,
                "size": size
            ] as [String : Any]
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
        case let .postBookmark(target):
            return .requestParameters(parameters: ["target": target], encoding: JSONEncoding.default)
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
        case .postEmail:
            return .requestPlain
        case .postSignUp(signUpDetails: let signUpDetails):
            return .requestJSONEncodable(signUpDetails)
        case .postLogin(loginDetails: let loginDetails):
            return .requestJSONEncodable(loginDetails)
        case .getVerifyEmail:
            return .requestPlain
        case .getReissue:
            return .requestPlain
        case .getMyOrganization:
            return .requestPlain
        case .patchMyClubProfile(let clubProfile):
            return .requestParameters(parameters: ["name": clubProfile.name, "description": clubProfile.description, "imageUrl": clubProfile.imageURL, "memberCount": clubProfile.memberCount, "clubTypes": clubProfile.clubTypes, "profileStatus": clubProfile.profileStatus], encoding: JSONEncoding.default)
            
        case .postProfileImage(let image, let fileName):
            let imageData = image.jpegData(compressionQuality: 0.1)!
            let formData = MultipartFormData(provider: .data(imageData), name: "profileImage", fileName: "image9.jpg", mimeType: "image/jpeg")
            return .uploadMultipart([formData])
        case let .getPortfolios(page, size, clubId):
            let parameters: [String: Any] = [
                "page": page,
                "size": size,
                "sort": "sorted",
                "clubId": clubId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .postPropose(let target):
            let param = ["target" : target]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getProposeSend(page, size):
            let parameters: [String: Any] = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .getProposeReceive(page, size):
            let parameters: [String: Any] = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        let accessToken: String = TokenManager.shared.accessToken ?? ""
        let auth = ["Authorization": "Bearer \(accessToken)"]
        
        switch self {
        case .getOrganizations:
            return auth
        case .getCompany:
            return auth
        case .getClub:
            return auth
        case .getBookmark:
            return auth
        case .postBookmark:
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
        case .postEmail(email: let email):
            return ["email": email]
        case .postSignUp:
            return ["Content-Type": "application/json"]
        case .postLogin:
            return ["Content-Type": "application/json"]
        case .getVerifyEmail(email: let email):
            return ["email": email]
        case .getReissue(refreshToken: let refreshToken):
            return ["RefreshToken": "\(refreshToken)"]
        case .getMyOrganization:
            return auth
        case .patchMyClubProfile:
            return auth
        case .postProfileImage:
            return auth
        case .getPortfolios:
            return auth
        case .postPropose:
            return auth
        case .getProposeSend:
            return auth
        case .getProposeReceive:
            return auth
        }
    }
}
