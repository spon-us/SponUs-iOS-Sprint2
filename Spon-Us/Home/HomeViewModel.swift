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
    private let authPlugin = AuthPlugin()
    private var provider: MoyaProvider<SponusAPI>!
    
    init() {
            setupProvider()
            setupAuthPluginCallbacks()
    }
    
    private func setupProvider() {
        self.provider = MoyaProvider<SponusAPI>(plugins: [authPlugin])
    }
    
    private func setupAuthPluginCallbacks() {
        authPlugin.onRetrySuccess = { [weak self] in
            // 재시도 성공 시 필요한 동작 추가.
        }
        authPlugin.onRetryFail = { [weak self] in
            // loginVM.logout()
        }
    }

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
        companyTypes: [],
        collaborationTypes: [],
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
        links: [],
        clubTypes: []
    )
    
    var selectedOrg: OrganizationModel = .init(
        id: 0, name: "", email: "", bookmarkCount: 0, viewCount: 0, organizationType: "", subTypes: [], isBookmarked: false)

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
    
    var currentBookmarkStatus = false
    
    func fetchOrganizations(type: CompanyClubSelection, completion: @escaping (Bool) -> Void) {
        provider.request(.getOrganizations(organizationType: type.rawValue)) {[weak self] response in
            switch response {
            case .success(let result):
                do {
                    let orgResponse = try JSONDecoder().decode(OrganizationResponseModel.self, from: result.data)
                    withAnimation {
                        switch type {
                        case .company:
                            self?.companies = orgResponse.content.content
                        case .club:
                            self?.clubs = orgResponse.content.content
                        }
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
                    withAnimation {
                        self?.selectedCompany = companyResponse.content
                    }
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
                    withAnimation {
                        self?.selectedClub = clubResponse.content
                    }
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
        withAnimation {
            switch type {
            case .all:
                filteredCompanies = companies
            case .beauty:
                filteredCompanies = companies.filter { $0.subTypes.contains("BEAUTY") }
            case .education:
                filteredCompanies = companies.filter { $0.subTypes.contains("EDUCATION") }
            case .food:
                filteredCompanies = companies.filter { $0.subTypes.contains("FOOD") }
            case .health:
                filteredCompanies = companies.filter { $0.subTypes.contains("HEALTH") }
            case .lifestyle:
                filteredCompanies = companies.filter { $0.subTypes.contains("LIFESTYLE") }
            case .others:
                filteredCompanies = companies.filter { $0.subTypes.contains("ETC") }
            }
        }
    }
    
    func filterClubs(_ type: ClubCategory) {
        withAnimation {
            switch type {
            case .all:
                filteredClubs = clubs
            case .advertisingAndMarketing:
                filteredClubs = clubs.filter { $0.subTypes.contains("AD_MARKETING") }
            case .design:
                filteredClubs = clubs.filter { $0.subTypes.contains("DESIGN") }
            case .iTAndSoftware:
                filteredClubs = clubs.filter { $0.subTypes.contains("IT_SOFTWARE") }
            case .photographyAndVideo:
                filteredClubs = clubs.filter { $0.subTypes.contains("PHOTO_VIDEO") }
            case .planningAndIdeas:
                filteredClubs = clubs.filter { $0.subTypes.contains("PLANNING_IDEA") }
            case .others:
                filteredClubs = clubs.filter { $0.subTypes.contains("ETC") }
            }
        }
    }
    
    func setTopID() {
        switch companyClubSelection {
        case .club:
            topID = filteredClubs.min { $0.id < $1.id }?.hashValue ?? -1
        case .company:
            topID = filteredCompanies.min { $0.id < $1.id }?.hashValue ?? -1
        }
    }
    
    func scrollToTop() {
        setTopID()
        withAnimation {
            scrollID = nil
            scrollID = topID
        }
    }
    
    func onSelectCompany() {
        fetchOrganizations(type: .company) {[weak self] success in
            if success {
                self?.filterCompanies(self?.companyCategory ?? .all)
                self?.companyClubSelection = .company
                self?.setTopID()
                self?.scrollID = nil
                self?.scrollID = self?.topID
            }
        }
    }
    
    func onSelectClub() {
        fetchOrganizations(type: .club) { [weak self] success in
            if success {
                self?.filterClubs(self?.clubCategory ?? .all)
                self?.companyClubSelection = .club
                self?.setTopID()
                self?.scrollID = nil
                self?.scrollID = self?.topID
            }
        }
    }
    
    func onSelectCompanyCategory(category: CompanyCategory) {
        fetchOrganizations(type: .company) { [weak self] completed in
            if completed {
                self?.filterCompanies(category)
                self?.companyCategory = category
                self?.setTopID()
                self?.scrollID = nil
                self?.scrollID = self?.topID
            }
        }
    }
    
    func onSelectClubCategory(category: ClubCategory) {
        fetchOrganizations(type: .club) { [weak self] completed in
            if completed {
                self?.filterClubs(category)
                self?.clubCategory = category
                self?.setTopID()
                self?.scrollID = nil
                self?.scrollID = self?.topID
            }
        }
    }
    
    func onTapCompany(companyId: Int) {
        fetchCompany(companyId: companyId) { [weak self] complete in
            if complete {
                self?.goToCompanyProfileView = true
            }
        }
    }
    
    func onTapClub(clubId: Int) {
        fetchClub(clubId: clubId) { [weak self] complete in
            if complete {
                self?.goToClubProfileView = true
            }
        }
    }
    
    func onHomeViewAppear() {
        fetchOrganizations(type: .company) { [weak self] success in
            if success {
                self?.fetchOrganizations(type: .club) { [weak self] success in
                    if success {
                        self?.filterCompanies(.all)
                        self?.filterClubs(.all)
                        self?.setTopID()
                    }
                }
            }
        }
    }
    
    func toggleBookmark(target: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.postBookmark(target: target)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let body = try JSONDecoder().decode(BookmarkPostResponseModel.self, from: response.data)
                    self?.currentBookmarkStatus = body.content.bookmarked
                    completion(true)
                } catch {
                    print("postBookmark parse error", error.localizedDescription)
                    completion(false)
                }
            case .failure(let error):
                print("postBookmark API error", error.localizedDescription)
                completion(false)
            }
        }
    }
}
