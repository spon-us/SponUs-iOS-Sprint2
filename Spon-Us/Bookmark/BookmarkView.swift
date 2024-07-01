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
                    fetchBookmarksForSelectedBookmark()
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
                    fetchBookmarksForSelectedBookmark()
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
                    fetchBookmarksForSelectedBookmark()
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
            
            BookmarkListView(bookmarkViewModel: bookmarkViewModel, selectedBookmark: $selectedBookmark, fetchBookmarksForSelectedBookmark: fetchBookmarksForSelectedBookmark)
            //                .navigationDestination(isPresented: $homeViewModel.goToCompanyProfileView) {
            //                    CompanyProfileView(
            //                         companyProfileViewModel: CompanyProfileViewModel(
            //                             companyModel: homeViewModel.selectedCompany
            //                         )
            //                     )
            //                }
        }
        .background(Color.bgSecondary)
        .onAppear {
            fetchBookmarksForSelectedBookmark()
        }
    }
    
    private func fetchBookmarksForSelectedBookmark() {
        switch selectedBookmark {
        case .recent:
            bookmarkViewModel.fetchBookmarks(sort: .recent) { success in
                if !success {
                    print("Failed to fetch recent bookmarks")
                }
            }
        case .company:
            bookmarkViewModel.fetchBookmarks(sort: .company) { success in
                if !success {
                    print("Failed to fetch company bookmarks")
                }
            }
        case .club:
            bookmarkViewModel.fetchBookmarks(sort: .club) { success in
                if !success {
                    print("Failed to fetch club bookmarks")
                }
            }
        }
    }
}

struct BookmarkListView: View {
    var bookmarkViewModel: BookmarkListViewModel
    @Binding var selectedBookmark: BookmarkSelection
    var fetchBookmarksForSelectedBookmark: () -> Void
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookmarkViewModel.bookmarkList) { cellViewModel in
                    BookmarkListCell(selectedBookmark: $selectedBookmark, bookmarkViewModel: bookmarkViewModel, bookmarkListCellViewModel: cellViewModel, fetchBookmarksForSelectedBookmark: fetchBookmarksForSelectedBookmark)
                }
            }
        }
        .padding(.horizontal, 20)
        .scrollIndicators(.hidden)
    }
}

struct BookmarkListCell: View {
    @Binding var selectedBookmark: BookmarkSelection
    var bookmarkViewModel: BookmarkListViewModel
    var bookmarkListCellViewModel: BookmarkListCellViewModel
    var fetchBookmarksForSelectedBookmark: () -> Void
    
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
                
                Button(action: {
                    bookmarkViewModel.postBookmark(target: bookmarkListCellViewModel.target) { success in
                        if success {
                            print("\(bookmarkListCellViewModel.companyName) 북마크 상태 업데이트 성공")
                            fetchBookmarksForSelectedBookmark()
                        } else {
                            print("북마크 상태 업데이트 실패")
                        }
                    }
                }, label: {
                    Image(.icBookmark)
                        .renderingMode(.template)
                        .foregroundStyle(Color.textBrand)
                })
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
