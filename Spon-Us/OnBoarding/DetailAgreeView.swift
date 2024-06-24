//
//  DetailAgreeView.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import SwiftUI

struct DetailAgreeView: View {
    let selectedIndex: Int
    var body: some View {
        switch selectedIndex {
        case 0:
            ScrollView {
                Image(.policy1)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
                    .padding(.horizontal, 20)
            }
        case 1:
            ScrollView {
                Image(.policy2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
                    .padding(.horizontal, 20)
            }
        case 2:
            ScrollView {
                Image(.policy3)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
                    .padding(.horizontal, 20)
            }
        case 3:
            ScrollView {
                Image(.policy4)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
                    .padding(.horizontal, 20)
            }
        default:
            Spacer()
        }
    }
}

#Preview {
    DetailAgreeView(selectedIndex: 1)
}
