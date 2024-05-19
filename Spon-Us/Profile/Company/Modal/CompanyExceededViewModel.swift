//
//  CompanyExceededViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/15/24.
//

import SwiftUI

struct CompanyExceededViewModel: View {
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
                Image(._117Caution)
                    .padding(.top, -20)
                    .padding(.leading, 32)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("하루 제안 횟수가 초과되었어요")
                    .korFont(.H3KrBd)
                    .foregroundStyle(Color.textPrimary)
                    .padding(.leading, 32)
                    .padding(.top, 8)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("하루 최대 5회까지 제안이 가능해요")
                    .korFont(.T4KrMd)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.leading, 32)
                    .padding(.top, 8)
                Spacer()
            }
            Button {
                dismiss()
            } label: {
                Text("알림 받기")
                    .korFont(.But1KrBd)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.textWhite)
                    .frame(maxWidth: .infinity)
                    .background(Color.textBrand)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }.padding([.top, .horizontal], 20)
            Button {
                dismiss()
            } label: {
                Text("확인")
                    .korFont(.But1KrMd)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.textSecondary)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }.padding(.horizontal, 20)
            Spacer()
        }
    }
}

#Preview {
    CompanyExceededViewModel()
}
