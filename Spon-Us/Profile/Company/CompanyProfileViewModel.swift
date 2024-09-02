//
//  CompanyProfileViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/14/24.
//

import SwiftUI
import Foundation
import Moya

@Observable
final class CompanyProfileViewModel {
    let provider: MoyaProvider<SponusAPI> = .init()
    
    var companyModel: CompanyModel
    var isBookmarked: Bool
    
    init(companyModel: CompanyModel, isBookmarked: Bool) {
        self.companyModel = companyModel
        self.isBookmarked = isBookmarked
    }
    
    var isSuggestModalPresented = false
    var profileStatus: ProfileStatus = .available
    var proposeExceptionCase: ProposeExceptionCase?

    func toggleBookmark(target: Int){
        provider.request(.postBookmark(target: target)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let body = try JSONDecoder().decode(BookmarkPostResponseModel.self, from: response.data)
                    withAnimation {
                        self?.isBookmarked = body.content.bookmarked
                    }
                    
                } catch {
                    print("postBookmark parse error", error.localizedDescription)
                }
            case .failure(let error):
                print("postBookmark API error", error.localizedDescription)
            }
        }
    }

    func convertCompanyTypeToKR(from type: String) -> String {
        switch type {
        case "NONE":
            return "없음"
        case "FOOD":
            return "식품"
        case "HEALTH":
            return "건강"
        case "LIFESTYLE":
            return "생활"
        case "EDUCATION":
            return "교육"
        case "BEAUTY":
            return "뷰티"
        case "ETC":
            return "기타"
        default:
            return "Unexpected Company Type"
        }
    }

    func convertCollabTypeToKR(from type: String) -> String {
        switch type {
        case "PARTNERSHIP_PROJECT":
            return "연계 프로젝트"
        case "ALLIANCE":
            return "제휴"
        case "SPONSORSHIP":
            return "협찬"
        default:
            return "Unexpected Collaboration Type"
        }
    }

    func makeProposal() {
        provider.request(.postPropose(target: companyModel.id)) { [weak self] result in
            switch result {
            case .success(let response):
                debugPrint(String(data: response.data, encoding: String.Encoding.utf8) ?? "")
                break
            case .failure(let err):
                let exceptionResponse: ProposeExceptionResponse
                debugPrint(String(data: err.response?.data ?? Data(), encoding: String.Encoding.utf8) ?? "")
                do {
                    exceptionResponse = try JSONDecoder().decode(ProposeExceptionResponse.self, from: err.response?.data ?? Data())

                    switch exceptionResponse.statusCode {
                    case "PROP4009":
                        self?.proposeExceptionCase = .exceeded
                    case "PROP4010":
                        self?.proposeExceptionCase = .hasNoProfile
                    case "PROP4011":
                        self?.proposeExceptionCase = .selfProposed
                    default:
                        self?.proposeExceptionCase = .networking
                    }
                } catch {
                    self?.proposeExceptionCase = .networking
                    debugPrint(error.localizedDescription)
                }
            }

            self?.isSuggestModalPresented = true
        }
    }
}
