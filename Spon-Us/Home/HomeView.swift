//
//  HomeView.swift
//  Spon-Us
//
//  Created by 박현수 on 5/8/24.
//

import SwiftUI


struct HomeView: View {
    @State var homeViewModel = HomeViewModel()
    var body: some View {
        VStack(spacing: 0) {
            HomeStatusBarView(homeViewModel: homeViewModel)
            if homeViewModel.isPortfolioUploaded {
                HomeCardGuestView(homeViewModel: homeViewModel)
            }
            HomeSelectionTabView(homeViewModel: homeViewModel)
            HomeCategorySelectionTab(homeViewModel: homeViewModel)
            HomeListView(homeViewModel: homeViewModel)
        }.background(Color.bgSecondary)
            .navigationDestination(isPresented: $homeViewModel.goToCompanyProfileVIew) {
                CompanyProfileView()
            }
    }
}


struct HomeStatusBarView: View {
    var homeViewModel: HomeViewModel
    var body: some View {
        HStack(spacing: 0) {
            Image(.logo)
                .padding([.top, .leading], 20)
            Spacer()
            Button {
                // 알림 View로 이동
            } label: {
                ZStack {
                    Image(.notification)
                    if homeViewModel.unreadNotificationsExist {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Spacer()
                                Circle()
                                    .foregroundStyle(Color.statusRed)
                                    .frame(width: 8, height: 8)
                            }.padding(.top, 1)
                                .padding(.trailing, 3)
                            Spacer()
                        }
                    }
                }
                .frame(width: 28, height: 28)
                .padding(6)
            }.padding([.top, .trailing], 20)
            
        }.frame(height: 56)
            .padding(.bottom, 20)
    }
}


struct HomeCardGuestView: View {
    var homeViewModel: HomeViewModel
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    if homeViewModel.isLoaded {
                        AsyncImage(url: URL(string: "https://www.example.com"))
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    else {
                        Image(.icGuest)
                            .renderingMode(.template)
                            .foregroundStyle(Color.bgWhite)
                            .padding(8)
                            .background(Color.bgTertiary)
                            .clipShape(Circle())
                    }
                    Spacer()
                }.padding(.trailing, 16)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Guest님")
                            .korFont(.T3KrBd)
                        Spacer()
                    }.padding(.bottom, 4)
                    HStack(spacing: 0) {
                        Text("포트폴리오를 업데이트하면\n기업과의 협업이 쉬워져요.")
                            .korFont(.B2KrRr)
                            .foregroundStyle(Color.textSecondary)
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    Spacer()
                }
            }.frame(height: 70)
                .padding(.bottom, 20)
            Button {
                // 작성하기
            } label: {
                Text("작성하기")
                    .foregroundStyle(Color.textWhite)
                    .korFont(.But1KrBd)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.textBrand)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 28)
        .background(Color.bgWhite)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.line200, lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
}

struct HomeSelectionTabView: View {
    var homeViewModel: HomeViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Text("기업")
                .korFont(.H4KrBd)
                .foregroundStyle(homeViewModel.companyClubSelection == .company ? Color.textPrimary : Color.textDisabled)
                .padding(.leading, 24)
                .onTapGesture {
                    withAnimation {
                        homeViewModel.companyClubSelection = .company
                    }
                }
            Text("동아리")
                .korFont(.H4KrBd)
                .foregroundStyle(homeViewModel.companyClubSelection == .club ? Color.textPrimary : Color.textDisabled)
                .padding(.leading, 16)
                .onTapGesture {
                    withAnimation {
                        homeViewModel.companyClubSelection = .club
                    }
                }
            Spacer()
        }.padding(.top, 38)
            .padding(.bottom, 14)
    }
}

struct HomeCategorySelectionCell: View {
    var homeViewModel: HomeViewModel
    let title: String
    let category: CompanyClubSelection
    let companySelection: CompanyCategory?
    let clubSelection: ClubCategory?
    var isCompanyMatched: Bool {
        homeViewModel.companyCategory == companySelection
    }
    var isClubMatched: Bool {
        homeViewModel.clubCategory == clubSelection
    }
    var body: some View {
        if companySelection != nil {
            Text(title)
                .korFont(.B1KrMd)
                .foregroundStyle(
                    isCompanyMatched ? Color.textBrand : Color.textDisabled
                )
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .clipShape(RoundedRectangle(cornerRadius: 999))
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(isCompanyMatched ? Color.textBrand : Color.line200, lineWidth: 1)
                ).padding(.trailing, 4)
        }
        else {
            Text(title)
                .korFont(.B1KrMd)
                .foregroundStyle(
                    isClubMatched ? Color.textBrand : Color.textDisabled
                )
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .clipShape(RoundedRectangle(cornerRadius: 999))
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(isClubMatched ? Color.textBrand : Color.line200, lineWidth: 1)
                ).padding(.trailing, 4)
        }
    }
}

struct HomeCategorySelectionTab: View {
    var homeViewModel: HomeViewModel
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                if homeViewModel.companyClubSelection == .company {
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "전체", category: .company, companySelection: .all, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .all
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "식품", category: .company, companySelection: .food, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .food
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "건강", category: .company, companySelection: .health, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .health
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "생활", category: .company, companySelection: .lifestyle, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .lifestyle
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "교육", category: .company, companySelection: .education, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .education
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "뷰티", category: .company, companySelection: .beauty, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .beauty
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "기타", category: .company, companySelection: .others, clubSelection: nil)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.companyCategory = .others
                            }
                        }
                }
                else {
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "전체", category: .club, companySelection: nil, clubSelection: .all)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .all
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "기획/아이디어", category: .club, companySelection: nil, clubSelection: .planningAndIdeas)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .planningAndIdeas
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "광고/마케팅", category: .club, companySelection: nil, clubSelection: .advertisingAndMarketing)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .advertisingAndMarketing
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "디자인", category: .club, companySelection: nil, clubSelection: .design)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .design
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "사진/영상", category: .club, companySelection: nil, clubSelection: .photographyAndVideo)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .photographyAndVideo
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "IT/소프트웨어", category: .club, companySelection: nil, clubSelection: .iTAndSoftware)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .iTAndSoftware
                            }
                        }
                    HomeCategorySelectionCell(homeViewModel: homeViewModel, title: "기타", category: .club, companySelection: nil, clubSelection: .others)
                        .onTapGesture {
                            withAnimation {
                                homeViewModel.clubCategory = .others
                            }
                        }
                }
            }.padding(.leading, 20)
                .padding(.vertical, 1)
        }.scrollIndicators(.hidden)
    }
}

struct HomeListCell: View {
    var homeListCellViewModel: HomeListCellViewModel
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                Image(.rectangle1363)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        Image(.icBookmark)
                            .renderingMode(.template)
                            .padding(.top, 12)
                            .padding(.trailing, 12)
                            .foregroundStyle(
                                homeListCellViewModel.isBookmarked ? Color.textBrand :  Color.textSecondary
                            )
                            .onTapGesture {
                                withAnimation {
                                    homeListCellViewModel.isBookmarked.toggle()
                                }
                            }
                    }
                    Spacer()
                }
            }
            HStack(spacing: 0) {
                Text(homeListCellViewModel.companyName)
                    .korFont(.T4KrBd)
                    .foregroundStyle(Color.textPrimary)
                Spacer()
            }.padding(.top, 12)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                Text("제안하기")
                    .korFont(.B2KrMd)
                    .foregroundStyle(Color.textSecondary)
                Image(.icRight)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.textSecondary)
                Spacer()
            }.padding(.top, 7)
                .padding(.bottom, 16)
                .padding(.leading, 20)
        }.background(Color.bgWhite)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.line200, lineWidth: 1)
            )
    }
}

struct HomeListView: View {
    var homeViewModel: HomeViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(1..<21) { index in
                    HomeListCell(homeListCellViewModel: HomeListCellViewModel(companyName: "무신사", imageURL: ""))
                        .onTapGesture {
                            homeViewModel.goToCompanyProfileVIew = true
                        }
                }
            }
        }.padding(.top, 15)
            .padding(.horizontal, 20)
            .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
