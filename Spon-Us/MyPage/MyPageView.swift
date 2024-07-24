//
//  MyPageView.swift
//  Spon-Us
//
//  Created by 황인성 on 5/19/24.
//

import SwiftUI


enum MyPageRoute: Hashable {
    case editProfileCell
    case writeClubProfile
    case writeClubPortfolio
    case cooperationHistory
    case contactUs
    case privacyPolicy
    case termsOfUse
//    case clubProfile = "내프로필"
    case writeCompanyProfile
    
    
    @ViewBuilder func view() -> some View {
        switch self {
        case .editProfileCell:
            EditProfileView()
        case .cooperationHistory:
            Text("이전 협업 관리")
        case .contactUs:
            Text("문의하기")
        case .privacyPolicy:
            PrivacyPolicyView()
        case .termsOfUse:
            TermsOfUseView()
        case .writeClubProfile:
            WriteClubProfileView()
        case .writeClubPortfolio:
            WriteClubPortfolioView()
//        case .clubProfile:
//            ClubProfileView2()
        case .writeCompanyProfile:
            WriteCompanyProfileView()
        }
    }
    
}

final class MypageNavigationPathFinder: ObservableObject {
    static let shared = MypageNavigationPathFinder()
    private init() { }
    
    @Published var path: [MyPageRoute] = []
    
    func addPath(route: MyPageRoute) {
        path.append(route)
    }
    
    func popToRoot() {
        path = .init()
    }
}

struct MyPageView: View {
    
    @EnvironmentObject var navPathFinder: MypageNavigationPathFinder
    @StateObject var mypageVM = MypageViewModel()
    
    var body: some View {
//        NavigationStack(path: $navPathFinder.path) {
            VStack(spacing: 0) {
                
                MyProfilCell(myOrganization: mypageVM.myOrganization)
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        Spacer()
                            .frame(height: 16)
                        
                        MyPageAlarmCell()
                        
                        Spacer()
                            .frame(height: 16)
                        
                        Button(action: {
                            if mypageVM.myOrganization?.organizationType == CompanyClubSelection.club.rawValue {
                                navPathFinder.path.append(.writeClubProfile)
                            }
                            else if mypageVM.myOrganization?.organizationType == CompanyClubSelection.company.rawValue {
                                navPathFinder.path.append(.writeCompanyProfile)
                            }
                        }, label: {
                            MyPageCell(image: "Profile", title: "프로필 수정")
                        })
                        
                        MyPageCell(image: "Folder", title: "이전 협업 관리")
                        MyPageCell(image: "Shield Done", title: "문의하기")
                        
                        Button(action: {
                            navPathFinder.path.append(.privacyPolicy)
                        }, label: {
                            MyPageCell(image: "Paper", title: "개안정보처리방침")
                        })
                        
                        Button(action: {
                            navPathFinder.path.append(.termsOfUse)
                        }, label: {
                            MyPageCell(image: "Info Circle", title: "이용약관")
                        })
                        
                        
                        logout
                        
                        cancellation
                        
                        Button(action: {
                            print(TokenManager.shared.accessToken)
                        }, label: {
                            Text("토큰 조회")
                        })
                        
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color.bgSecondary)
            }
            .navigationDestination(for: MyPageRoute.self) { route in
                route.view()
            }
            .onAppear {
                mypageVM.getMyOrganization()
            }
//        }
    }
    
    var logout: some View {
        Text("로그아웃")
            .font(.B2KrMd)
            .foregroundColor(Color.textPrimary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.bgTertiary)
                    .stroke(Color.line200, lineWidth: 1)
            )
    }
    
    var cancellation: some View {
        Text("계정탈퇴")
            .font(.B4KrMd)
            .foregroundColor(Color.textDisabled)
            .padding(10)
    }
}


struct MyProfilCell: View {
    
    var myOrganization: MyOrganization?
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                Rectangle()
                    .frame(maxWidth: 56, maxHeight: 56)
                    .clipShape(Circle())
                    .padding(.leading, 20)
                    .padding(.trailing, 8)
                
                Text(myOrganization?.name ?? "name")
                    .korFont(.H4KrBd)
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
            }
            .padding(.vertical, 24)
            
            Rectangle()
                .fill(Color.line200)
                .frame(height: 1)
            
        }
    }
}





struct MyPageAlarmCell: View {
    var body: some View {
        HStack(spacing: 0) {
            
            Rectangle()
                .frame(maxWidth: 40, maxHeight: 40)
                .clipShape(Circle())
                .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("무신사")
                    .font(.B2KrMd)
                    .foregroundStyle(Color.textSecondary)
                
                Text("제안이 수락됐어요")
                    .font(.T4KrBd)
                    .foregroundStyle(Color.textBrand)
            }
            
            Spacer()
            
            Image("Arrow - Right 5")
                .resizable()
                .frame(maxWidth: 20, maxHeight: 20)
            
        }
        .padding(.vertical, 16)
        .padding(.leading, 23)
        .padding(.trailing, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.bgBrandSecondary)
        )
    }
}

struct MyPageCell: View {
    
    var image: String
    var title: String
    @EnvironmentObject var navPathFinder: MypageNavigationPathFinder
    
    var body: some View {
        
//        Button(action: {
//            navPathFinder.addPath(route: title)
//        }, label: {
            
            HStack(spacing: 0) {
                Image(image)
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color.textTertiary)
                    .padding(.trailing, 20)
                    .padding(.horizontal, 4)
                
                Text(title)
                    .font(.T4KrBd)
                    .foregroundColor(Color.textPrimary)
                    .padding(.trailing, 8)
                
                if(title == "프로필 수정") {
                    Text("추천")
                        .font(.B2KrBd)
                        .foregroundStyle(Color.textBrand)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.bgBrandSecondary)
                        )
                }
                
                Spacer()
                
                Image("Arrow - Right 5")
                    .resizable()
                    .frame(maxWidth: 16, maxHeight: 16)
            }
            .padding(.vertical, 16)
//        })
    }
}

#Preview {
    MyPageView()
        .environmentObject(MypageNavigationPathFinder.shared)
}

struct ClubProfileView2: View {
    @State var clubProfileViewModel: ClubProfileViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        ClubProfileCardView(clubProfileViewModel: clubProfileViewModel)
                        ClubIntroductionView(clubProfileViewModel: clubProfileViewModel)
                        ClubSNSView(clubProfileViewModel: clubProfileViewModel)
                        ClubProfilePortfolioView(clubProfileViewModel: clubProfileViewModel)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .scrollIndicators(.hidden)
                
                ClubEditButton(clubProfileViewModel: clubProfileViewModel)
                
            }
            .background(Color.bgSecondary)
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {
                    CustomBackButton()
                    CustomNavigationTitle(title: "동아리 프로필")
                }
            }
        }
    }
}

struct ClubEditButton: View {
    var clubProfileViewModel: ClubProfileViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Divider().foregroundStyle(Color.line200)
                .padding(.bottom, 20)
            
            HStack(spacing: 0) {
                Button {
                    
                } label: {
                    Text("포트폴리오 수정")
                        .korFont(.But1KrBd)
                        .frame(maxWidth: .infinity)
                      .foregroundStyle(Color.textBrand)
                      .padding(.vertical, 16)
                      .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.bgBrandSecondary)
                      )
                }
                .padding(.trailing, 7)
                
                Button {
                    
                } label: {
                    Text("내용 수정")
                        .korFont(.But1KrBd)
                        .frame(maxWidth: .infinity)
                      .foregroundStyle(Color.textBrand)
                      .padding(.vertical, 16)
                      .padding(.horizontal, 32)
                      .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.bgBrandSecondary)
                      )
                }
            }
            .padding(.horizontal, 20)
        }.background(Color.bgWhite)
    }
}
