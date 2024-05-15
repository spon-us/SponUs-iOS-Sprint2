//
//  CompanyProfileVIew.swift
//  Spon-Us
//
//  Created by 박현수 on 5/14/24.
//

import SwiftUI

struct CompanyProfileView: View {
    @State var companyProfileViewModel =  CompanyProfileViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ProfileCardView(companyProfileViewModel: companyProfileViewModel)
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(Color.bgSecondary)
            if companyProfileViewModel.isSuggestModalPresented {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.7))
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {
                    CustomBackButton()
                    CustomNavigationTitle(title: "기업 프로필")
                }
            }
        }
        .sheet(isPresented: $companyProfileViewModel.isSuggestModalPresented) {
            CompanyUnavailableModal()
                .presentationDetents( [.height(307.69)] )
                .presentationCornerRadius(32)
                .presentationDragIndicator(.hidden)
        }
    }
}

struct ProfileCardView: View {
    var companyProfileViewModel: CompanyProfileViewModel
    var body: some View {
        VStack(spacing: 0) {
            
            Image(.rectangle1363)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack(spacing: 0) {
                Text(companyProfileViewModel.companyname)
                    .korFont(.H3KrBd)
                    .padding(.top, 20)
                    .padding(.leading, 28)
                Spacer()
            }
            
            HStack(spacing: 0) {
                Text("협업 유형")
                    .korFont(.T4KrMd)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.leading, 28)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< companyProfileViewModel.coworkCategory.count, id: \.self) { index in
                            Text(companyProfileViewModel.coworkCategory[index].rawValue)
                                .font(.T4KrMd)
                                .foregroundStyle(Color.textPrimary)
                            if (index != companyProfileViewModel.coworkCategory.count - 1) {
                                Ellipse().frame(width: 4, height: 4)
                                    .foregroundStyle(Color.line200)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }.frame(height: 24)
                    .padding(.leading, 24)
                    .padding(.trailing, 28)
                    .scrollIndicators(.hidden)
            }.padding(.top, 8)
            
            HStack(spacing: 0) {
                Text("기업 분야")
                    .korFont(.T4KrMd)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.leading, 28)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< companyProfileViewModel.companyCategory.count, id: \.self) { index in
                            Text(companyProfileViewModel.companyCategory[index].rawValue)
                                .korFont(.T4KrMd)
                                .foregroundStyle(Color.textPrimary)
                            if (index != companyProfileViewModel.companyCategory.count - 1) {
                                Ellipse().frame(width: 4, height: 4)
                                    .foregroundStyle(Color.line200)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }.frame(height: 24)
                    .padding(.leading, 24)
                    .padding(.trailing, 28)
                    .scrollIndicators(.hidden)
                    
            }.padding(.top, 4)
            
            if !companyProfileViewModel.sponsoredGoods.isEmpty {
                HStack(spacing: 0) {
                    Text("협찬 물품")
                        .korFont(.T4KrMd)
                        .foregroundStyle(Color.textSecondary)
                        .padding(.leading, 28)
                    ScrollView(.horizontal) {
                        Text(companyProfileViewModel.sponsoredGoods)
                            .korFont(.T4KrMd)
                            .foregroundStyle(Color.textPrimary)
                          
                    }.frame(height: 24)
                        .padding(.leading, 24)
                        .padding(.trailing, 28)
                        .scrollIndicators(.hidden)
                }.padding(.top, 4)
            }

            HStack(spacing: 0) {
                Image(.icBookmark)
                    .renderingMode(.template)
                    .foregroundStyle(companyProfileViewModel.isBookmarked ? Color.textBrand : Color.textDisabled)
                    .padding(14)
                    .background(Color.bgTertiary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onTapGesture {
                        withAnimation {
                            companyProfileViewModel.isBookmarked.toggle()
                        }
                    }
                Button {
                    withAnimation {
                        companyProfileViewModel.isSuggestModalPresented = true
                    }
                } label: {
                    Text("제안하기")
                        .korFont(.But1KrBd)
                        .padding(.vertical, 14)
                        .foregroundStyle(Color.textWhite)
                        .frame(maxWidth: .infinity)
                        .background(Color.textBrand)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }.padding(.leading, 8)
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

#Preview {
    CompanyProfileView()
}
