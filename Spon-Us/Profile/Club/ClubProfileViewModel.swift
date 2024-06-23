//
//  ClubProfileViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/16/24.
//

import Foundation
import SwiftUI

@Observable
final class ClubProfileViewModel {
    var isSuggestModalPresented: Bool = false
    var clubName: String = "스포너스기획동아리동아리스"
    var clubCategory: [ClubCategory] = [.planningAndIdeas, .iTAndSoftware, .photographyAndVideo]
    var isBookmarked: Bool = false
    var clubMemberCount: Int = 342
    var clubIntroduction: String = "안녕하세요 저희는 스포대학교 기획동아리 입니다. 안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는 스포대학교 기획동아리 입니다. 안녕하세요 저희는 스포대학교 기획동아리 입니다. 안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는 스포대학교 기획동아리 입니다. 안녕하세요 저희는 스포대학교 기획동아리 입니다.안녕하세요 저희는"
    var snsURL: [String] = ["https://www.instagram.com/sponus_official?igsh=aXZ4OG85cGcxcDQw", "https://www.facebook.com", "https://www.example.com"]
    var cardnewsDummyData = [PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel()]
    
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
}
