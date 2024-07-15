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
    var cardnewsDummyData = [PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel()]
    
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
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
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
}
