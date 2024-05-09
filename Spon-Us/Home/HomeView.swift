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
            StatusBarView(homeViewModel: homeViewModel)
            ScrollView {
                if homeViewModel.isPortfolioUploaded {
                    CardGuestView(homeViewModel: homeViewModel)
                }
            }.padding(.horizontal, 20)
        }.background(Color.bgSecondary)
    }
}

struct StatusBarView: View {
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
    }
}

struct CardGuestView: View {
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
                .padding(.bottom, 21)
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
    }
}


#Preview {
    HomeView()
}
