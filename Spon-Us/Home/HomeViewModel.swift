//
//  HomeViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/8/24.
//

import Foundation

enum HomeCompanyClubSelection {
    case club, company
}

enum HomeCompanyCategory {
    case all, food, health, lifestyle, education, beauty, others
}

enum HomeClubCategory {
    case all, planningAndIdeas, advertisingAndMarketing, design, photographyAndVideo, iTAndSoftware, others
}

@Observable
final class HomeViewModel {
    var isLoaded = false
    var unreadNotificationsExist = false
    var isPortfolioUploaded = true
    var companyClubSelection = HomeCompanyClubSelection.company
    var homeCompanyCategory = HomeCompanyCategory.all
    var homeClubCategory = HomeClubCategory.all
}
