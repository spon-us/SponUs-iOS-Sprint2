//
//  MyPageView.swift
//  Spon-Us
//
//  Created by 황인성 on 5/19/24.
//

import SwiftUI


enum MyPageRoute: String, Hashable {
    case editProfileCell = "프로필 수정"
    case writeProfile = "프로필 작성하기"
    case writePortfolio = "포트폴리오 작성하기"
    case cooperationHistory = "이전 협업 관리"
    case contactUs = "문의하기"
    case privacyRule = "개인정보처리방침"
    case termsOfUse = "이용약관"
    
    @ViewBuilder func view() -> some View {
        switch self {
        case .editProfileCell:
            EditProfileView()
        case .cooperationHistory:
            Text("이전 협업 관리")
        case .contactUs:
            Text("문의하기")
        case .privacyRule:
            Text("개인정보처리방침")
        case .termsOfUse:
            Text("이용약관")
        case .writeProfile:
            WriteProfileView()
        case .writePortfolio:
            WritePortfolioView()
        }
    }
    
}

final class NavigationPathFinder: ObservableObject {
    static let shared = NavigationPathFinder()
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
    
    @EnvironmentObject var navPathFinder: NavigationPathFinder
    
    var body: some View {
        NavigationStack(path: $navPathFinder.path) {
            VStack(spacing: 0) {
                
                MyProfilCell()
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        Spacer()
                            .frame(height: 16)
                        
                        MyPageAlarmCell()
                        
                        Spacer()
                            .frame(height: 16)
                        
                        MyPageCell(image: "Profile", title: .editProfileCell)
                        MyPageCell(image: "Folder", title: .cooperationHistory)
                        MyPageCell(image: "Shield Done", title: .contactUs)
                        MyPageCell(image: "Paper", title: .privacyRule)
                        MyPageCell(image: "Info Circle", title: .termsOfUse)
                        
                        logout
                        
                        cancellation
                        
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color.bgSecondary)
            }
            .navigationDestination(for: MyPageRoute.self) { route in
                route.view()
            }
        }
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
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                Rectangle()
                    .frame(maxWidth: 56, maxHeight: 56)
                    .clipShape(Circle())
                    .padding(.leading, 20)
                    .padding(.trailing, 8)
                
                Text("스포너스기획동아리동아리스")
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
    var title: MyPageRoute
    @EnvironmentObject var navPathFinder: NavigationPathFinder
    
    var body: some View {
        
        Button(action: {
            navPathFinder.addPath(route: title)
        }, label: {
            
            HStack(spacing: 0) {
                Image(image)
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color.textTertiary)
                    .padding(.trailing, 20)
                    .padding(.horizontal, 4)
                
                Text(title.rawValue)
                    .font(.T4KrBd)
                    .foregroundColor(Color.textPrimary)
                    .padding(.trailing, 8)
                
                if(title.rawValue == "프로필 수정") {
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
        })
    }
}

#Preview {
    MyPageView()
        .environmentObject(NavigationPathFinder.shared)
}
