//
//  BookmarkView.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/12/24.
//

import SwiftUI

struct BookmarkView: View {
    @State private var isRecentSelected: Bool = true
    @State private var isCompanySelected: Bool = false
    @State private var isClubSelected: Bool = false
    
    @State var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    isRecentSelected = true
                    isCompanySelected = false
                    isClubSelected = false
                }, label: {
                    Text("최근 본")
                        .korFont(.T4KrBd)
                        .foregroundStyle(isRecentSelected ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 103, height: 40)
                })
                .background(isRecentSelected ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
                
                Button(action: {
                    isRecentSelected = false
                    isCompanySelected = true
                    isClubSelected = false
                }, label: {
                    Text("기업")
                        .korFont(.T4KrBd)
                        .foregroundStyle(isCompanySelected ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 103, height: 40)
                })
                .background(isCompanySelected ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
                
                Button(action: {
                    isRecentSelected = false
                    isCompanySelected = false
                    isClubSelected = true
                }, label: {
                    Text("동아리")
                        .korFont(.T4KrBd)
                        .foregroundStyle(isClubSelected ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 103, height: 40)
                })
                .background(isClubSelected ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 56)
            .background(Color.bgTertiary)
            .cornerRadius(20)
            .padding(.all, 20)
            
            BookmarkListView(homeViewModel: homeViewModel)
                .navigationDestination(isPresented: $homeViewModel.goToCompanyProfileVIew) {
                    CompanyProfileView()
                }
        }
        .background(Color.bgSecondary)
    }
}

struct BookmarkListView: View {
    var homeViewModel: HomeViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(1..<10) { index in
                    BookmarkListCell(bookmarkListCellViewModel: BookmarkListCellViewModel(companyName: "무신사", imageURL: ""))
                        .onTapGesture {
                            homeViewModel.goToCompanyProfileVIew = true
                        }
                }
            }
        }
        .padding(.horizontal, 20)
        .scrollIndicators(.hidden)
    }
}

struct BookmarkListCell: View {
    var bookmarkListCellViewModel: BookmarkListCellViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(.rectangle1363)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.line200, lineWidth: 1)
                    )
                
                Text(bookmarkListCellViewModel.companyName)
                    .korFont(.T4KrBd)
                    .foregroundStyle(Color.textPrimary)
                    .padding(.leading, 6)
                
                Spacer()
                
                Image(.icBookmark)
                    .renderingMode(.template)
                    .foregroundStyle(
                        bookmarkListCellViewModel.isBookmarked ? Color.textBrand :  Color.textDisabled
                    )
                    .onTapGesture {
                        withAnimation {
                            bookmarkListCellViewModel.isBookmarked.toggle()
                        }
                    }
            }
            .padding(.all, 20)
        }
        .background(Color.bgWhite)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.line200, lineWidth: 1)
        )
    }
}


#Preview {
    BookmarkView()
}
