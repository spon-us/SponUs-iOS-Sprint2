//
//  ClubProfileView.swift
//  Spon-Us
//
//  Created by 박현수 on 5/16/24.
//

import SwiftUI

struct ClubProfileView: View {
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
                }.padding(.horizontal, 20)
                    .scrollIndicators(.hidden)
                ClubProfileProposeButton(clubProfileViewModel: clubProfileViewModel)
            }.background(Color.bgSecondary)

            if clubProfileViewModel.isSuggestModalPresented {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.7))
            }
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
        .sheet(isPresented: $clubProfileViewModel.isSuggestModalPresented) {
            ClubExceededModal()
                .presentationDetents( [.height(310.69)] )
                .presentationCornerRadius(32)
                .presentationDragIndicator(.hidden)
        }
    }
}

struct ClubProfileCardView: View {
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

struct ClubIntroductionView: View {
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

struct ClubSNSView: View {
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



struct InstagramCell: View {
    var body: some View {
        Image(.instagram)
            .padding(.leading, 20)
        Text("instagram")
            .font(.B2EnBd)
            .foregroundStyle(Color.textPrimary)
            .padding(.leading, 12)
    }
}

struct FacebookCell: View {
    var body: some View {
        Image(.facebook)
            .padding(.leading, 20)
        Text("facebook")
            .font(.B2EnBd)
            .foregroundStyle(Color.textPrimary)
            .padding(.leading, 12)
    }
}

struct WebsiteCell: View {
    var body: some View {
        Image(.website)
            .padding(.leading, 20)
        Text("website")
            .font(.B2EnBd)
            .foregroundStyle(Color.textPrimary)
            .padding(.leading, 12)
    }
}

struct ClubProfilePortfolioView: View {
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
        if clubProfileViewModel.showMoreButton {
            Button {
                withAnimation {
                    clubProfileViewModel.fetchPortfolios()
                }
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
                .onAppear(perform: clubProfileViewModel.fetchPortfolios)
        }
    }
}

struct ClubProfilePortfolioPageView: View {
    @Bindable var clubProfileViewModel: ClubProfileViewModel
    var body: some View {
        if let pfIdx = clubProfileViewModel.pfIdx {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(clubProfileViewModel.portfolios[pfIdx].portfolioImageGetResponses.indices, id: \.self) { idx in
                            VStack(spacing: 0) {
                                ZStack {
                                    AsyncImage(url: URL(string: clubProfileViewModel.portfolios[pfIdx].portfolioImageGetResponses[idx].url)) { image in
                                        image
                                            .resizable()
                                            .frame(maxWidth: .infinity)
                                            .aspectRatio(1.717, contentMode: .fit)
                                    } placeholder: {
                                        Rectangle()
                                            .foregroundStyle(.clear)
                                            .aspectRatio(1.717, contentMode: .fit)
                                    }
                                    VStack(spacing: 0) {
                                        Spacer()
                                        HStack(spacing: 8) {
                                            ForEach(clubProfileViewModel.portfolios[pfIdx].portfolioImageGetResponses.indices, id: \.self) { dotIndex in
                                                Circle()
                                                    .frame(width: 8, height: 8)
                                                    .foregroundColor(dotIndex == idx ? Color.bgWhite : Color.textDisabled)
                                            }
                                        }
                                        .padding(.bottom, 8)
                                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                            content
                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                        }
                                    }
                                }
                            }
                            .containerRelativeFrame(.horizontal)
                            .background(Color.bgWhite)
                        }
                    }
                }.scrollTargetBehavior(.paging)
                HStack(spacing: 0) {
                    Text(clubProfileViewModel.portfolios[pfIdx].startDate + " ~ " + clubProfileViewModel.portfolios[pfIdx].endDate)
                        .korFont(.B2KrMd)
                        .foregroundStyle(Color.textSecondary)
                    Spacer()
                }.padding([.top, .horizontal], 20)

                HStack(spacing: 0) {
                    Text(clubProfileViewModel.portfolios[pfIdx].title ?? "Dummy Title")
                        .korFont(.T3KrBd)
                        .lineLimit(1)
                        .foregroundStyle(Color.textPrimary)
                    Spacer()
                }.padding(.horizontal, 20)
                    .padding(.top, 6)

                HStack(spacing: 0) {
                    Text(clubProfileViewModel.portfolios[pfIdx].description.forceCharWrapping)
                        .korFont(.B2KrMd)
                        .foregroundStyle(Color.textSecondary)
                    Spacer()
                }.padding(.horizontal, 20)
                    .padding(.top, 9)
                    .padding(.bottom, 20)
            }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.line200, lineWidth: 1)
                )
        } else {
            EmptyView()
        }
    }
}

struct ClubProfileVGridView: View {
    @Bindable var clubProfileViewModel: ClubProfileViewModel

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(clubProfileViewModel.portfolios.indices, id: \.self) { idx in
                if let imgURL = clubProfileViewModel.portfolios[idx].portfolioImageGetResponses.first?.url {
                    AsyncImage(url: URL(string: imgURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.line200, lineWidth: 1)
                            )
                            .onTapGesture {
                                withAnimation {
                                    clubProfileViewModel.pfIdx = idx
                                }
                            }
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .aspectRatio(1, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.line200, lineWidth: 1)
                            )
                    }
                }
            }
        }.padding(.top, 12)
    }
}

struct ClubProfileProposeButton: View {
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

//#Preview {
//    ClubProfileView()
//}
