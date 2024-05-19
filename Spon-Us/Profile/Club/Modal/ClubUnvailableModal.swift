//
//  ClubUnvailableModal.swift
//  Spon-Us
//
//  Created by 박현수 on 5/17/24.
//

import SwiftUI

struct ClubUnavailableModal: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(.icX)
                }.padding([.top, .trailing], 12)
            }
            HStack(spacing: 0) {
                Image(.icGuest)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(Color.textBrand)
                    .frame(width: 42.67, height: 42.67)
                    .padding(10.67)
                    .background(Color.bgBrandSecondary)
                    .clipShape(Circle())
                    .padding(.top, -20)
                    .padding(.leading, 32)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("프로필을 작성하면\n제안이 가능해요")
                    .korFont(.H3KrBd)
                    .foregroundStyle(Color.textPrimary)
                    .lineSpacing(5)
                    .padding(.leading, 32)
                    .padding(.top, 8)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("프로필을 작성한 뒤 다시 제안해 주세요")
                    .korFont(.T4KrMd)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.leading, 32)
                    .padding(.top, 8)
                Spacer()
            }
            Button {
                dismiss()
            } label: {
                Text("작성하러 가기")
                    .korFont(.But1KrBd)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.textWhite)
                    .frame(maxWidth: .infinity)
                    .background(Color.textBrand)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }.padding(20)
            Spacer()
        }
    }
}


#Preview {
    ClubUnavailableModal()
}
