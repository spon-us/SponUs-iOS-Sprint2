//
//  CustomNavigationTitle.swift
//  Spon-Us
//
//  Created by 박현수 on 5/14/24.
//

import SwiftUI

struct CustomNavigationTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .korFont(.T2KrBd)
            .foregroundStyle(Color.textPrimary)
            .padding(.leading, 4)
    }
}
