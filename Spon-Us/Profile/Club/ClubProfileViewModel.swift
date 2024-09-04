//
//  ClubProfileViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/16/24.
//

import Moya
import Foundation
import SwiftUI

@Observable
final class ClubProfileViewModel {
    let provider: MoyaProvider<SponusAPI> = .init()
    var clubModel: ClubModel
    var isBookmarked: Bool
    
    var isSuggestModalPresented: Bool = false
    var snsURL: [String] = ["https://www.instagram.com/sponus_official?igsh=aXZ4OG85cGcxcDQw", "https://www.facebook.com", "https://www.example.com"]
    
    var portfolioPage: Int = 0
    var portfolios: [PortfolioModel] = .init()
    var pfIdx: Int?
    
    var showMoreButton: Bool = true

    let cardnewsDummyData = [PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel()]

    var proposeExceptionCase: ProposeExceptionCase?

    var isProposeButtonTapped: Bool = false
    
    init(clubModel: ClubModel, isBookmarked: Bool) {
        self.clubModel = clubModel
        self.isBookmarked = isBookmarked
    }
    
    @ViewBuilder
    func snsViewBuilder(index: Int) -> some View {
        switch index {
        case 0:
            InstagramCell()
        case 1:
            FacebookCell()
        case 2:
            WebsiteCell()
        default:
            EmptyView()
        }
    }
    
    func openLink(_ urlString: String) {
        var prefixed = urlString
        if !urlString.lowercased().hasPrefix("http://") && !urlString.lowercased().hasPrefix("https://") {
            prefixed = "https://\(urlString)"
        }
        guard let url = URL(string: prefixed), UIApplication.shared.canOpenURL(url) else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
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

    func convertClubTypeToKR(from type: String) -> String {
        switch type {
        case "NONE":
            return "없음"
        case "PLANNING_IDEA":
            return "기획/아이디어"
        case "AD_MARKETING":
            return "광고/마케팅"
        case "DESIGN":
            return "디자인"
        case "PHOTO_VIDEO":
            return "사진/영상"
        case "IT_SOFTWARE":
            return "IT/소프트웨어"
        case "ETC":
            return "기타"
        default:
            return "Unexpected Club Type"
        }
    }

    func fetchPortfolios() {
        provider.request(.getPortfolios(page: portfolioPage, size: 3, clubId: clubModel.id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let body = try JSONDecoder().decode(GetPortfolioResponse.self, from: response.data)
                    withAnimation {
                        if self?.portfolioPage == 0 {
                            self?.portfolios = body.content.content
                        }
                        else {
                            for elem in body.content.content {
                                self?.portfolios.append(elem)
                            }
                        }
                        if body.content.content.count < 3 {
                            self?.showMoreButton = false
                        }
                    }
                    self?.portfolioPage += 1
                } catch {
                    debugPrint("getPortoflio parse err", error)
                }
            case .failure(let err):
                debugPrint(err)
            }
        }
    }

    func makeProposal() {
        print("proposal")
        isProposeButtonTapped = true
        provider.request(.postPropose(target: clubModel.id)) { [weak self] result in
            switch result {
            case .success(let response):
                break
            case .failure(let err):
                let exceptionResponse: ProposeExceptionResponse
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
