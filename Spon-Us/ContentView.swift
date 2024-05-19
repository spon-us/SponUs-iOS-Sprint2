//
//  ContentView.swift
//  Spon-Us
//
//  Created by 박현수 on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        VStack {
                            Image(.icHome)
                                .renderingMode(.template)
                            Text("홈")
                                .korFont(.C3KrMd)
                        }
                    }
                    .tag(0)
                Text("검색")
                    .tabItem {
                        VStack {
                            Image(.icSearch)
                                .renderingMode(.template)
                            Text("검색")
                                .korFont(.C3KrMd)
                        }
                    }
                    .tag(1)
                BookmarkView()
                    .tabItem {
                        VStack {
                            Image(.icBookmark)
                                .renderingMode(.template)
                            Text("북마크")
                                .korFont(.C3KrMd)
                        }
                    }
                    .tag(2)
                MyPageView()
                    .environmentObject(NavigationPathFinder.shared)
                    .tabItem {
                        VStack {
                            Image(.icMy)
                                .renderingMode(.template)
                            Text("마이")
                                .korFont(.C3KrMd)
                        }
                    }
                    .tag(3)
            }.onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.backgroundColor = UIColor.white
                // 배경 흰색
                tabBarAppearance.backgroundImage = UIImage()
                // 투명도 제거
                tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 0, green: 0.42, blue: 1, alpha: 1)
                // 선택된 아이템 textBrand
                tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.57, green: 0.61, blue: 0.65, alpha: 1)
                // 선택 안된 아이템 textDisabled
                UITabBar.appearance().standardAppearance = tabBarAppearance
                // 기본 탭바 appearance
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                // 스크롤 시 탭바 appearance
            }
        }
    }
}

#Preview {
    ContentView()
}
