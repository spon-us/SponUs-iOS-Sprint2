//
//  HomeViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/8/24.
//
import SwiftUI
import Foundation
import Moya

@Observable
final class HomeViewModel {
    let provider = MoyaProvider<SponusAPI>()
    
    var companies: [OrganizationModel] = []
    var clubs: [OrganizationModel] = []
    
    var filteredCompanies: [OrganizationModel] = []
    var filteredClubs: [OrganizationModel] = []
    
    var selectedCompany: CompanyModel = .init(
        id: 0,
        name: "",
        email: "",
        description: "",
        imageUrl: "",
        bookmarkCount: 0,
        viewCount: 0,
        organizationType: "",
        profileStatus: "",
        role: "",
        companyType: "",
        collaborationType: "",
        sponsorshipContent: ""
    )
    
    var selectedClub: ClubModel = .init(
        id: 0,
        name: "",
        email: "",
        description: "",
        imageUrl: "",
        bookmarkCount: 0,
        viewCount: 0,
        organizationType: "",
        profileStatus: "",
        role: "",
        memberCount: 0,
        clubType: ""
    )
    
    var isLoaded = false
    var unreadNotificationsExist = false
    
    var scrollID: Int?
    var topID: Int = -1
    
    var isPortfolioUploaded = true
    var companyClubSelection = CompanyClubSelection.company
    var companyCategory = CompanyCategory.all
    var clubCategory = ClubCategory.all
    var goToCompanyProfileView = false
    var goToClubProfileView = false
    
    func fetchOrganizations(type: CompanyClubSelection, completion: @escaping (Bool) -> Void) {
        provider.request(.getOrganizations(organizationType: type.rawValue)) {[weak self] response in
            switch response {
            case .success(let result):
                do {
                    let orgResponse = try JSONDecoder().decode(OrganizationResponseModel.self, from: result.data)
                    switch type {
                    case .company:
                        self?.companies = orgResponse.content.content
                    case .club:
                        self?.clubs = orgResponse.content.content
                    }
                    completion(true)
                } catch {
                    print("fetch org decode error", error.localizedDescription)
                    completion(false)
                }
                
            case .failure(let err):
                print("getOrg API error", err.localizedDescription)
                completion(false)
            }
        }
    }
    
    func fetchCompany(companyId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.getCompany(companyId: companyId)) {[weak self] response in
            switch response {
            case .success(let response):
                do {
                    let companyResponse = try JSONDecoder().decode(CompanyResponseModel.self, from: response.data)
                    self?.selectedCompany = companyResponse.content
                    completion(true)
                } catch {
                    print("fetch company decode error", error.localizedDescription)
                    completion(false)
                }
            case .failure(let err):
                print("getCompany API error", err.localizedDescription)
                completion(false)
            }
        }
    }
    
    func fetchClub(clubId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.getClub(clubId: clubId)) {[weak self] response in
            switch response {
            case .success(let response):
                do {
                    let clubResponse = try JSONDecoder().decode(ClubResponseModel.self, from: response.data)
                    self?.selectedClub = clubResponse.content
                    completion(true)
                } catch {
                    print("fetch club decode error", error.localizedDescription)
                    completion(false)
                }
            case .failure(let err):
                print("getClub API error", err.localizedDescription)
                completion(false)
            }
        }
    }
    
    func filterCompanies(_ type: CompanyCategory) {
        switch type {
        case .all:
            filteredCompanies = companies
        case .beauty:
            filteredCompanies = companies.filter { $0.subType == "BEAUTY" }
        case .education:
            filteredCompanies = companies.filter { $0.subType == "EDUCATION" }
        case .food:
            filteredCompanies = companies.filter { $0.subType == "FOOD" }
        case .health:
            filteredCompanies = companies.filter { $0.subType == "HEALTH" }
        case .lifestyle:
            filteredCompanies = companies.filter { $0.subType == "LIFESTYLE" }
        case .others:
            filteredCompanies = companies.filter { $0.subType == "ETC" }
        }
    }
    
    func filterClubs(_ type: ClubCategory) {
        switch type {
        case .all:
            filteredClubs = clubs
        case .advertisingAndMarketing:
            filteredClubs = clubs.filter { $0.subType == "AD_MARKETING" }
        case .design:
            filteredClubs = clubs.filter { $0.subType == "DESIGN" }
        case .iTAndSoftware:
            filteredClubs = clubs.filter { $0.subType == "IT_SOFTWARE" }
        case .photographyAndVideo:
            filteredClubs = clubs.filter { $0.subType == "PHOTO_VIDEO" }
        case .planningAndIdeas:
            filteredClubs = clubs.filter { $0.subType == "PLANNING_IDEA" }
        case .others:
            filteredClubs = clubs.filter { $0.subType == "ETC" }
        }
    }
    
    func scrollToTop() {
        switch companyClubSelection {
        case .club:
            topID = filteredClubs.min { $0.id < $1.id }?.id ?? -1
        case .company:
            topID = filteredCompanies.min { $0.id < $1.id }?.id ?? -1
        }
        scrollID = topID
    }
    
    func onSelectCompany() {
        withAnimation {
            fetchOrganizations(type: .company) {[weak self] success in
                if success {
                    self?.filterCompanies(self?.companyCategory ?? .all)
                    self?.companyClubSelection = .company
                    self?.scrollToTop()
                }
            }
        }
    }
    
    func onSelectClub() {
        withAnimation {
            fetchOrganizations(type: .club) { [weak self] success in
                if success {
                    self?.filterClubs(self?.clubCategory ?? .all)
                    self?.companyClubSelection = .club
                    self?.scrollToTop()
                }
            }
        }
    }
    
    func onSelectCompanyCategory(category: CompanyCategory) {
        withAnimation {
            fetchOrganizations(type: .company) { [weak self] completed in
                if completed {
                    self?.filterCompanies(category)
                    self?.companyCategory = category
                    self?.scrollToTop()
                }
            }
        }
    }
    
    func onSelectClubCategory(category: ClubCategory) {
        withAnimation {
            fetchOrganizations(type: .club) { [weak self] completed in
                if completed {
                    self?.filterClubs(category)
                    self?.clubCategory = category
                    self?.scrollToTop()
                }
            }
        }
    }
    
    func onTapCompany(companyId: Int) {
        withAnimation {
            fetchCompany(companyId: companyId) { [weak self] complete in
                if complete {
                    self?.goToCompanyProfileView = true
                }
            }
        }
    }
    
    func onTapClub(clubId: Int) {
        withAnimation {
            fetchClub(clubId: clubId) { [weak self] complete in
                if complete {
                    self?.goToClubProfileView = true
                }
            }
        }
    }
    
    func onHomeViewAppear() {
        fetchOrganizations(type: .company) { [weak self] success in
            if success {
                self?.filterCompanies(.all)
                self?.scrollToTop()
            }
        }
        fetchOrganizations(type: .club) { [weak self] success in
            if success {
                self?.filterClubs(.all)
            }
        }
    }
}
