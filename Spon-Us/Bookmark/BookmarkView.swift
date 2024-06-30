//
//  BookmarkView.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/12/24.
//

import SwiftUI

enum BookmarkSelection {
    case recent
    case company
    case club
}

struct BookmarkView: View {
    @State private var selectedBookmark: BookmarkSelection = .recent
    
    var bookmarkViewModel = BookmarkListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    selectedBookmark = .recent
                    bookmarkViewModel.fetchBookmarks(sort: .recent) { success in
                        if !success {
                            print("Failed to fetch recent bookmarks")
                        }
                    }
                }, label: {
                    Text("최근 본")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedBookmark == .recent ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 103, height: 40)
                })
                .background(selectedBookmark == .recent ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
                
                Button(action: {
                    selectedBookmark = .company
                    bookmarkViewModel.fetchBookmarks(sort: .company) { success in
                        if !success {
                            print("Failed to fetch company bookmarks")
                        }
                    }
                }, label: {
                    Text("기업")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedBookmark == .company ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 103, height: 40)
                })
                .background(selectedBookmark == .company ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
                
                Button(action: {
                    selectedBookmark = .club
                    bookmarkViewModel.fetchBookmarks(sort: .club) { success in
                        if !success {
                            print("Failed to fetch club bookmarks")
                        }
                    }
                }, label: {
                    Text("동아리")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedBookmark == .club ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 103, height: 40)
                })
                .background(selectedBookmark == .club ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 56)
            .background(Color.bgTertiary)
            .cornerRadius(20)
            .padding(.all, 20)
            
            BookmarkListView(bookmarkViewModel: bookmarkViewModel)
//                .navigationDestination(isPresented: $homeViewModel.goToCompanyProfileView) {
//                    CompanyProfileView()
//                }
        }
        .background(Color.bgSecondary)
        .onAppear {
            bookmarkViewModel.fetchBookmarks(sort: .recent) { success in
                if !success {
                    print("Failed to fetch recent bookmarks")
                }
            }
        }
    }
}

struct BookmarkListView: View {
    var bookmarkViewModel: BookmarkListViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookmarkViewModel.bookmarkList) { cellViewModel in
                    BookmarkListCell(bookmarkListCellViewModel: cellViewModel)
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
                if let imageURL = bookmarkListCellViewModel.imageURL, !imageURL.isEmpty {
                    Image(uiImage: loadImage(from: imageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.line200, lineWidth: 1)
                        )
                } else {
                    Image("sponus")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.line200, lineWidth: 1)
                        )
                }
                
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

func loadImage(from urlString: String) -> UIImage {
    guard let url = URL(string: urlString),
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data) else {
        return UIImage(named: "sponus")!
    }
    return image
}
