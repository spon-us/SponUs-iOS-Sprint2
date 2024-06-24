//
//  EditProfileView.swift
//  Spon-Us
//
//  Created by 황인성 on 6/22/24.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var selectedSection = ""
    @EnvironmentObject var navPathFinder: NavigationPathFinder
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                    
                    Text("입력할 프로필 섹션을\n선택해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 32)
                    
                    
                    HStack(spacing: 0) {
                        
                        ProfileSectionCell(selectedSection: $selectedSection, section: "profile", imageName: "Profile", description: "프로필 내용")
                        
                        Spacer()
                        
                        ProfileSectionCell(selectedSection: $selectedSection, section: "portfolio", imageName: "Wallet", description: "포트폴리오")
                        
                        
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                if selectedSection == "profile" {
                    navPathFinder.addPath(route: .writeProfile)
                }
                else if selectedSection == "portfolio" {
                    navPathFinder.addPath(route: .writePortfolio)
                }
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: selectedSection.isEmpty)
            })
            .disabled(selectedSection.isEmpty)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
}

struct ProfileSectionCell: View {
    
    @Binding var selectedSection: String
    
    var section: String
    var imageName: String
    var description: String
    
    var body: some View {
        Button(action: {
            if selectedSection == section {
                selectedSection = ""
            }
            else {
                selectedSection = section
            }
        }, label: {
            VStack(spacing: 0) {
                ZStack {
                    
                    Image(imageName)
                        .resizable()  // 이미지가 조절 가능하도록 함
                        .renderingMode(.template)
                        .foregroundStyle(Color.textBrand)
                        .aspectRatio(contentMode: .fit)  // 비율을 유지하면서 맞춤
                        .frame(width: 40)  // 원하는 크기로 프레임 설정
                        .zIndex(1)
                    
                    Circle()
                        .fill(Color.bgBrandSecondary)
                        .frame(maxWidth: 64)
                    
                }
                .padding(.bottom, 12)
                
                Text(description)
                    .font(.T4KrBd)
                    .foregroundStyle(Color.textPrimary)
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 46)
            .background(Color.bgWhite)
            .cornerRadius(16)
            .overlay(
                ZStack(alignment: .topTrailing) {
                    
                    if selectedSection == section {
                        
                        Image("Tick Square")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.textBrand)
                            .frame(width: 36)
                            .padding(.top, 8)
                            .padding(.trailing, 8)
                    }
                    RoundedRectangle(cornerRadius: 16)
                        .inset(by: selectedSection == section ? 1 : 0.5)
                    .stroke(selectedSection == section ? Color.textBrand : Color.line200, lineWidth: 2)
                }
            )
        })
    }
}

struct SponusButtonLabel: View {
    
    var text: String
    var disabledCondition: Bool
    
    var body: some View {
        Text(text)
            .font(.But1KrBd)
            .foregroundStyle(disabledCondition ? Color.textDisabled : Color.textWhite)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 16)
          .background(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: disabledCondition ? 0.5 : 0)
                .fill(disabledCondition ? Color.line100 : Color.textBrand)
                .stroke(disabledCondition ? Color.line200 : Color.clear, lineWidth: 1)


          )
    }
}



#Preview {
    EditProfileView()
}
