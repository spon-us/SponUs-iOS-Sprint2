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
    
    
//    @ViewBuilder func view() -> some View {
//        switch self {
//        case .editProfileCell:
//            EditProfileView()
//        case .cooperationHistory:
//            Text("이전 협업 관리")
//        case .contactUs:
//            Text("문의하기")
//        case .privacyPolicy:
//            PrivacyPolicyView()
//        case .termsOfUse:
//            TermsOfUseView()
//        case .writeClubProfile:
//            WriteClubProfileView(mypageVM: <#MypageViewModel#>)
//        case .writeClubPortfolio:
//            WriteClubPortfolioView()
////        case .clubProfile:
////            ClubProfileView2()
//        case .writeCompanyProfile:
//            WriteCompanyProfileView()
//        }
//    }
    
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
                
                MyProfilCell(mypageVM: mypageVM)
                
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        Spacer()
                            .frame(height: 16)
                        
                        MyPageAlarmCell()
                        
                        Spacer()
                            .frame(height: 16)
                        
                        
                        
                        Button(action: {
//                            if mypageVM.myOrganization?.organizationType == CompanyClubSelection.club.rawValue {
//                                
////                                if mypageVM.myOrganization?.profileStatus == "INACTIVE" {
////                                    navPathFinder.path.append(.writeClubProfile)
////                                }
////                                else if mypageVM.myOrganization?.profileStatus == "ACTIVE" {
////                                    navPathFinder.path.append(.writeClubProfile)
////                                }
//                                
//                            }
//                            else if mypageVM.myOrganization?.organizationType == CompanyClubSelection.company.rawValue {
//                                navPathFinder.path.append(.writeCompanyProfile)
//                            }
//                            else {
//                                navPathFinder.path.append(.writeClubProfile)
//                            }
                            
                            if mypageVM.myOrganizationType == "CLUB" {
                                navPathFinder.path.append(.writeClubProfile)
                            }
                            else if mypageVM.myOrganizationType == "COMPANY" {
                                navPathFinder.path.append(.writeCompanyProfile)
                            }
                            else {
                                print("잘못된 조직타입")
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
                        
                        Button(action: {
                            navPathFinder.path.append(.writeClubPortfolio)
                        }, label: {
                            Text("동아리 포트폴리오 작성")
                        })
                        
                        logout
                        
                        cancellation
                        
                        Button(action: {
                            print(TokenManager.shared.accessToken)
                        }, label: {
                            Text("토큰 조회")
                        })
                        Button(action: {
                            print(mypageVM.clubOrganization)
                        }, label: {
                            Text("단체정보 조회")
                        })
                        Button(action: {
                            print(mypageVM.companyOrganization)
                        }, label: {
                            Text("기업정보 조회")
                        })
                        
                        Button(action: {
                            mypageVM.patchClubProfile(clubProfile: ClubProfile(name: "ninini", description: "asdasd", imageURL: "asdas", memberCount: 10, clubTypes: ["PLANNING_IDEA", "AD_MARKETING"], profileStatus: "ACTIVE"))
                        }, label: {
                            Text("패치 테스트")
                        })
                        
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color.bgSecondary)
            }
            .navigationDestination(for: MyPageRoute.self) { route in
                switch route {
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
                    WriteClubProfileView(mypageVM: mypageVM)
                case .writeClubPortfolio:
                    WriteClubPortfolioView()
        //        case .clubProfile:
        //            ClubProfileView2()
                case .writeCompanyProfile:
                    WriteCompanyProfileView()
                }
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
    
    @ObservedObject var mypageVM: MypageViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                Rectangle()
                    .frame(maxWidth: 56, maxHeight: 56)
                    .clipShape(Circle())
                    .padding(.leading, 20)
                    .padding(.trailing, 8)
                
                if mypageVM.myOrganizationType == "CLUB" {
                    Text(mypageVM.clubOrganization?.name ?? "unname")
                        .korFont(.H4KrBd)
                        .foregroundStyle(Color.textPrimary)
                    
                }
                else if mypageVM.myOrganizationType == "COMPANY" {
                    Text(mypageVM.companyOrganization?.name ?? "unname")
                        .korFont(.H4KrBd)
                        .foregroundStyle(Color.textPrimary)
                    
                }
                
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
                        ClubProfileCardView2(clubProfileViewModel: clubProfileViewModel)
                        ClubIntroductionView2(clubProfileViewModel: clubProfileViewModel)
                        ClubSNSView2(clubProfileViewModel: clubProfileViewModel)
                        ClubProfilePortfolioView2(clubProfileViewModel: clubProfileViewModel)
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

struct ClubProfileCardView2: View {
    var clubProfileViewModel: ClubProfileViewModel
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: clubProfileViewModel.clubModel.imageUrl ?? "")) { image in
                image.resizable().aspectRatio(1, contentMode: .fit)
            } placeholder: {
                Image(.rectangle1363)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            }


            HStack(spacing: 0) {
                Text(clubProfileViewModel.clubModel.name)
                    .korFont(.H3KrBd)
                    .padding(.top, 20)
                    .padding(.leading, 28)
                Spacer()
            }

            HStack(spacing: 0) {
                Text("동아리 분야")
                    .korFont(.T4KrMd)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.leading, 28)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< clubProfileViewModel.clubModel.clubTypes.count, id: \.self) { index in
                            Text(clubProfileViewModel.clubModel.clubTypes[index])
                                .korFont(.T4KrMd)
                                .foregroundStyle(Color.textPrimary)
                            if (index != clubProfileViewModel.clubModel.clubTypes.count - 1) {
                                Ellipse().frame(width: 4, height: 4)
                                    .foregroundStyle(Color.line200)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }.frame(height: 24)
                    .padding(.leading, 12)
                    .padding(.trailing, 25)
                    .scrollIndicators(.hidden)

            }.padding(.top, 8)


            HStack(spacing: 0) {
                Image(.icBookmark)
                    .renderingMode(.template)
                    .foregroundStyle(clubProfileViewModel.isBookmarked ? Color.textBrand : Color.textDisabled)
                    .padding(14)
                    .background(Color.bgTertiary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onTapGesture {
                        withAnimation {
                            clubProfileViewModel.toggleBookmark(target: clubProfileViewModel.clubModel.id)
                            //                            homeVM.toggleBookmarkForClub(id: clubProfileViewModel.clubModel.id)
                        }
                    }
                Text("\(clubProfileViewModel.clubModel.memberCount)명 활동 중")
                    .korFont(.But1KrBd)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.textBrand)
                    .frame(maxWidth: .infinity)
                    .background(Color.bgBrandSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.leading, 8)
                    .padding(.trailing, 28)
            }
            .padding([.vertical, .leading], 28)

        }.background(Color.bgWhite)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.line200, lineWidth: 1)
            )
            .padding(.top, 24)
    }
}

struct ClubIntroductionView2: View {
    var clubProfileViewModel: ClubProfileViewModel
    var body: some View {
        HStack(spacing: 0) {
            Text("동아리 소개")
                .korFont(.H4KrBd)
            Spacer()
        }.padding(.leading, 4)
            .padding(.top, 40)
            .padding(.bottom, 12)
        Text(clubProfileViewModel.clubModel.description?.forceCharWrapping ?? "아직 소개가 입력되지 않았습니다")
            .korFont(.B2KrMd)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(clubProfileViewModel.clubModel.description == nil ? Color.textDisabled : Color.textPrimary)
            .padding(20)
            .lineSpacing(3)
            .background(Color.bgWhite)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.line200, lineWidth: 1)
            )
    }
}

struct ClubSNSView2: View {
    var clubProfileViewModel: ClubProfileViewModel
    var body: some View {
        HStack(spacing: 0) {
            Text("활동 중인 SNS")
                .korFont(.H4KrBd)
            Spacer()
        }.padding(.leading, 4)
            .padding(.top, 40)
            .padding(.bottom, 12)

        VStack(spacing: 8) {
            if let instagram = clubProfileViewModel.clubModel.links.first(where: { $0.name == "instagram" }) {
                Button {
                    clubProfileViewModel.openLink(instagram.url)
                } label: {
                    HStack(spacing: 0) {
                        InstagramCell()
                        Spacer()
                        Image(.icRight)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(Color.textSecondary)
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 20)

                    }.frame(height: 64)
                        .background(Color.bgWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.line200, lineWidth: 1)
                        )
                }
            }
            if let facebook = clubProfileViewModel.clubModel.links.first(where: { $0.name == "facebook" }) {
                Button {
                    clubProfileViewModel.openLink(facebook.url)
                } label: {
                    HStack(spacing: 0) {
                        FacebookCell()
                        Spacer()
                        Image(.icRight)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(Color.textSecondary)
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 20)

                    }.frame(height: 64)
                        .background(Color.bgWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.line200, lineWidth: 1)
                        )
                }
            }
            if let homepage = clubProfileViewModel.clubModel.links.first(where: { $0.name == "homepage" }) {
                Button {
                    clubProfileViewModel.openLink(homepage.url)
                } label: {
                    HStack(spacing: 0) {
                        WebsiteCell()
                        Spacer()
                        Image(.icRight)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(Color.textSecondary)
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 20)

                    }.frame(height: 64)
                        .background(Color.bgWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.line200, lineWidth: 1)
                        )
                }
            }
        }
    }
}



struct ClubProfilePortfolioView2: View {
    let colors: [Color] = [.red, .yellow, .cyan, .blue, .teal, .brown, .orange, .indigo]

    var clubProfileViewModel: ClubProfileViewModel
    var body: some View {
        HStack(spacing: 0) {
            Text("포트폴리오")
                .korFont(.H4KrBd)
            Spacer()
        }.padding(.leading, 4)
            .padding(.top, 40)
            .padding(.bottom, 12)
        ClubProfilePortfolioPageView(clubProfileViewModel: clubProfileViewModel)
        ClubProfileVGridView(clubProfileViewModel: clubProfileViewModel)
        Button {
            // 더보기
        } label: {
            Text("더보기")
                .korFont(.B2KrMd)
                .foregroundStyle(Color.textSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.bgTertiary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.line200, lineWidth: 1)
                )
        }.padding(.top, 20)
            .padding(.bottom, 93)
    }
}

struct ClubProfilePortfolioPageView2: View {
    var clubProfileViewModel: ClubProfileViewModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(clubProfileViewModel.cardnewsDummyData.indices, id: \.self) { index in
                    VStack(spacing: 0) {
                        ZStack {
                            clubProfileViewModel.cardnewsDummyData[index].image
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .aspectRatio(1.717, contentMode: .fit)
                            VStack(spacing: 0) {
                                Spacer()
                                HStack(spacing: 8) {
                                    ForEach(clubProfileViewModel.cardnewsDummyData.indices, id: \.self) { dotIndex in
                                        Circle()
                                            .frame(width: 8, height: 8)
                                            .foregroundColor(dotIndex == index ? Color.bgWhite : Color.textDisabled)
                                    }
                                }
                                .padding(.bottom, 8)
                                .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                }
                            }
                        }

                        HStack(spacing: 0) {
                            Text(clubProfileViewModel.cardnewsDummyData[index].date)
                                .korFont(.B2KrMd)
                                .foregroundStyle(Color.textSecondary)
                            Spacer()
                        }.padding([.top, .horizontal], 20)

                        HStack(spacing: 0) {
                            Text(clubProfileViewModel.cardnewsDummyData[index].title.forceCharWrapping)
                                .korFont(.T3KrBd)
                                .foregroundStyle(Color.textPrimary)
                            Spacer()
                        }.padding(.horizontal, 20)
                            .padding(.top, 6)

                        HStack(spacing: 0) {
                            Text(clubProfileViewModel.cardnewsDummyData[index].content.forceCharWrapping)
                                .korFont(.B2KrMd)
                                .foregroundStyle(Color.textSecondary)
                            Spacer()
                        }.padding(.horizontal, 20)
                            .padding(.top, 9)
                            .padding(.bottom, 20)
                    }
                    .containerRelativeFrame(.horizontal)
                    .background(Color.bgWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.line200, lineWidth: 1)
                    )
                }
            }
        }.scrollTargetBehavior(.paging)
    }
}

struct ClubProfileVGridView2: View {
    var clubProfileViewModel: ClubProfileViewModel

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(1..<7) { _ in
                Image(.rectangle1363)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }.padding(.top, 12)
    }
}

struct ClubProfileProposeButton2: View {
    var clubProfileViewModel: ClubProfileViewModel

    var body: some View {
        VStack(spacing: 0) {
            Divider().foregroundStyle(Color.line200)
            Button {
                withAnimation {
                    clubProfileViewModel.isSuggestModalPresented = true
                }
            } label: {
                Text("제안하기")
                    .korFont(.But1KrBd)
                    .padding(.vertical, 16)
                    .foregroundStyle(Color.textWhite)
                    .frame(maxWidth: .infinity)
                    .background(Color.textBrand)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }.padding(20)
        }.background(Color.bgWhite)
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
