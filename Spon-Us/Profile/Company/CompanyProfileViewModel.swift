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
    
    var coworkCategory: [CoworkCategory] = [.linkedProject, .partnership, .sponsorship]
    var companyCategory: [CompanyCategory] = [.food, .education, .beauty]
    var sponsoredGoods: [String] = ["풀무원선물세트풀무원선물세트풀무원선물세트풀무원선물세트", "김", "쌀", "두부"]
    
    var isSuggestModalPresented = false
    var profileStatus: ProfileStatus = .available
    
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
}
