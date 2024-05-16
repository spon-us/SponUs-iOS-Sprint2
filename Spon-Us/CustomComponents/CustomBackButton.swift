//
//  CustomBackButton.swift
//  Spon-Us
//
//  Created by 박현수 on 5/14/24.
//

import Foundation
import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.icRight)
                .renderingMode(.template)
                .scaleEffect(x: -1, y: 1)
                .foregroundStyle(Color.textBrand)
        }
    }
}
