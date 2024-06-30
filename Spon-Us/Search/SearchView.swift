//
//  SearchView.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/18/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchData: String = ""
    @State private var recentSearches: [String] = []
    var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(searchData: $searchData, recentSearches: $recentSearches, searchViewModel: searchViewModel, performSearch: performSearch)
            
            VStack(spacing: 0) {
                if recentSearches.isEmpty {
                    Spacer().frame(height: 44)
                } else {
                    HStack {
                        Text("최근 검색어")
                            .korFont(.T2KrBd)
                            .foregroundStyle(Color.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            searchViewModel.deleteSearch { success in
                                searchViewModel.searchList = []
                                if success {
                                    searchViewModel.fetchKeyword { success in
                                        if success {
                                            print("검색어 전체 삭제 성공")
                                            recentSearches = searchViewModel.recentSearches
                                        } else {
                                            print("검색 기록 조회 실패")
                                        }
                                    }
                                } else {
                                    print("검색어 전체 삭제 실패")
                                }
                            }
                        }, label: {
                            Text("전체삭제")
                                .korFont(.B2KrMd)
                                .foregroundStyle(Color.textTertiary)
                                .padding(10)
                                .frame(width: 68, alignment: .center)
                        })
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 14)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(recentSearches, id: \.self) { search in
                                HStack(spacing: 0) {
                                    Text(search)
                                        .korFont(.B1KrMd)
                                        .foregroundStyle(Color.textSecondary)
                                        .onTapGesture {
                                            searchData = search
                                            performSearch()
                                        }
                                    
                                    Button(action: {
                                        searchViewModel.deleteKeyword(keyword: search) { success in
                                            if success {
                                                searchViewModel.searchList = []
                                                searchViewModel.fetchKeyword { success in
                                                    if success {
                                                        recentSearches = searchViewModel.recentSearches
                                                    } else {
                                                        print("검색 기록 조회 실패")
                                                    }
                                                }
                                                print("검색어 \(search) 삭제 성공")
                                            } else {
                                                print("검색어 개별 삭제 실패")
                                            }
                                        }
                                    }, label: {
                                        Image(.icDelete)
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.gray)
                                    })
                                }
                                .padding(.leading, 12)
                                .padding(.trailing, 10)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 999)
                                        .inset(by: 0.5)
                                        .stroke(Color.line200, lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                }
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(searchViewModel.searchList, id: \.id) { search in
                            Button {
                                // TODO: 검색 결과 화면 연결
                                print(search.id)
                            } label: {
                                HStack {
                                    if let imageURL = search.imageURL, let url = URL(string: imageURL) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Image("musinsa")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        }
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipped()
                                        .clipShape(Circle())
                                    } else {
                                        Image("musinsa")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                    }
                                    
                                    Text(search.name)
                                        .korFont(.T4KrBd)
                                        .foregroundStyle(Color.textPrimary)
                                        .padding(.leading, 12)
                                    
                                    Spacer()
                                    
                                    Image(.icRight3)
                                        .frame(width: 40, height: 40)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.leading, 20)
        }
        .background(Color.bgSecondary)
        .onAppear {
            searchViewModel.fetchKeyword { success in
                if success {
                    recentSearches = searchViewModel.recentSearches
                } else {
                    print("검색 기록 조회 실패")
                }
            }
            UIApplication.shared.hideKeyboard()
        }
    }
    
    func performSearch() {
        searchViewModel.fetchSearch(keyword: searchData) { success in
            if success {
                print("조직 검색 성공")
            } else {
                print("조직 검색 실패")
            }
        }
        
        searchViewModel.postKeyword(keyword: searchData) { success in
            if success {
                // 동일한 검색어가 입력될 때 해당 검색어가 맨 앞에 오도록 순서 변경
                if let index = recentSearches.firstIndex(of: searchData) {
                    recentSearches.remove(at: index)
                }
                recentSearches.insert(searchData, at: 0)
            } else {
                print("검색어 저장 실패")
            }
        }
    }
}

struct SearchBarView: View {
    @Binding var searchData: String
    @Binding var recentSearches: [String]
    var searchViewModel: SearchViewModel
    var performSearch: () -> Void
    
    var body: some View {
        HStack {
            CustomBackButton()
                .frame(width: 40, height: 40)
                .padding(.leading, 5)
            
            TextField("협업할 기업 혹은 동아리를 검색해 보세요.", text: $searchData, onCommit: {
                if !searchData.isEmpty {
                    performSearch()
                }
            })
            .font(.B1KrMd)
            .foregroundStyle(Color.textPrimary)
            .padding(.horizontal, 20)
            .padding(.vertical, 13)
            .frame(height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 0.5)
                    .stroke(Color.line200, lineWidth: 1)
            )
            .padding(.trailing, 20)
        }
        .frame(height: 56)
    }
}
