//
//  SearchView.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/18/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchData: String = ""
    @State private var recentSearches: [String] = ["무신사", "코카콜라", "해커스", "스포너스"]
    
    var body: some View {
        VStack {
            SearchBarView(searchData: $searchData, recentSearches: $recentSearches)
            
            VStack {
                if recentSearches.isEmpty {
                    Spacer().frame(height: 44)
                } else {
                    HStack {
                        Text("최근 검색어")
                            .korFont(.T2KrBd)
                            .foregroundStyle(Color.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            recentSearches.removeAll()
                        }, label: {
                            Text("전체삭제")
                                .korFont(.B2KrMd)
                                .foregroundStyle(Color.textTertiary)
                                .padding(10)
                                .frame(width: 68, alignment: .center)
                        })
                    }
                    .padding(.trailing, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(recentSearches, id: \.self) { search in
                                HStack {
                                    Text(search)
                                        .korFont(.B2KrMd)
                                        .foregroundStyle(Color.textSecondary)
                                        .onTapGesture {
                                            searchData = search
                                        }
                                    
                                    Button(action: {
                                        if let index = recentSearches.firstIndex(of: search) {
                                            recentSearches.remove(at: index)
                                        }
                                    }, label: {
                                        Image(systemName: "xmark")
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
                        .padding(.vertical, 10)
                    }
                }
                Spacer()
            }
            .padding(.leading, 20)
        }
    }
}

struct SearchBarView: View {
    @Binding var searchData: String
    @Binding var recentSearches: [String]
    
    var body: some View {
        HStack {
            CustomBackButton()
                .frame(width: 40, height: 40)
                .padding(.leading, 5)
            
            TextField("협업할 기업 혹은 동아리를 검색해 보세요.", text: $searchData, onCommit: {
                if !searchData.isEmpty {
                    // 동일한 검색어가 입력될 때 해당 검색어가 맨 앞에 오도록 순서 변경
                    if let index = recentSearches.firstIndex(of: searchData) {
                        recentSearches.remove(at: index)
                    }
                    recentSearches.insert(searchData, at: 0)
                    searchData = ""
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
    }
}

#Preview {
    SearchView()
}
