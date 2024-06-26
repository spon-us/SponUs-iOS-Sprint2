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
    var clubModel: ClubModel
    
    var isSuggestModalPresented: Bool = false
    var clubCategory: [ClubCategory] = [.planningAndIdeas, .iTAndSoftware, .photographyAndVideo]
    var isBookmarked: Bool = false
    var snsURL: [String] = ["https://www.instagram.com/sponus_official?igsh=aXZ4OG85cGcxcDQw", "https://www.facebook.com", "https://www.example.com"]
    var cardnewsDummyData = [PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel(), PortfolioCardNewsDummyModel()]
    
    init(clubModel: ClubModel) {
        self.clubModel = clubModel
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
}
