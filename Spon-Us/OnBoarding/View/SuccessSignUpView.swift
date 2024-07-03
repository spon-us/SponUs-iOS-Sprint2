//
//  SuccessSignUpView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/3/24.
//

import SwiftUI

struct SuccessSignUpView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack() {
            Image("logo_app")
                .resizable()
                .frame(width: 120, height: 120)
                .padding(.top, 214)
                .padding(.horizontal, 127)
            
            VStack(spacing: 8) {
                Text("가입을 환영해요")
                    .font(.H3KrBd)
                    .foregroundColor(.textPrimary)
                Text("이제 다양한 기업, 학생과 협업을 맺어보세요")
                    .font(.T4KrMd)
                    .foregroundColor(.textTertiary)
            }
            .padding(.top, 131)
            .padding(.horizontal, 54.5)
            
            Spacer()
            
            Button(action: {
                loginVM.logout()
            }) {
                Text("시작하기")
                    .font(.But1KrBd)
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .foregroundColor(.textWhite)
                    .background(Color.textBrand)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.textBrand)
                    )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.bgSecondary)
    }
}

#Preview {
    SuccessSignUpView()
}
