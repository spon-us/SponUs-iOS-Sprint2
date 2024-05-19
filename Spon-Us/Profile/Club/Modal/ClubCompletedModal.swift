//
//  ClubCompletedModal.swift
//  Spon-Us
//
//  Created by 박현수 on 5/17/24.
//

import SwiftUI

struct ClubCompletedModal: View {
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
                Image(._113Check)
                    .padding(.top, -20)
                    .padding(.leading, 32)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("제안이 완료되었어요")
                    .korFont(.H3KrBd)
                    .foregroundStyle(Color.textPrimary)
                    .padding(.leading, 32)
                    .padding(.top, 8)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("곧 기업으로의 수신 결과 알림을\n전송해 드릴게요.")
                    .korFont(.T4KrMd)
                    .lineSpacing(4)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.leading, 32)
                    .padding(.top, 8)
                Spacer()
            }
            Button {
                dismiss()
            } label: {
                Text("확인")
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
    ClubCompletedModal()
}
