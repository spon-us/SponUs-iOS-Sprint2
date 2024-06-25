//
//  HomeViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/8/24.
//

import Foundation
import Moya

@Observable
final class HomeViewModel {
    let provider = MoyaProvider<SponusAPI>()
    
    var companies: [OrganizationModel] = []
    var clubs: [OrganizationModel] = []
    
    var isLoaded = false
    var unreadNotificationsExist = false
    var isPortfolioUploaded = true
    var companyClubSelection = CompanyClubSelection.company
    var companyCategory = CompanyCategory.all
    var clubCategory = ClubCategory.all
    var goToCompanyProfileView = false
    var goToClubProfileView = false
    
    func fetchOrganizations(type: CompanyClubSelection) {
        provider.request(.getOrganizations(page: 0, size: 0, organizationType: type.rawValue)) { response in
            switch response {
            case .success(let result):
                do {
                    let orgResponse = try JSONDecoder().decode(OrganizationResponseModel.self, from: result.data)
                    switch type {
                    case .company:
                        self.companies = orgResponse.content.content
                    case .club:
                        self.clubs = orgResponse.content.content
                    }
                } catch {
                    print("fetch org decode error", error.localizedDescription)
                }
                
            case .failure(let err):
                print("getOrg API error", err.localizedDescription)
            }
        }
    }
}
