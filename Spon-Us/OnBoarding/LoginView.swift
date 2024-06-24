//
//  LoginView.swift
//  Spon-Us
//
//  Created by 김수민 on 6/23/24.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var loginVM: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image("logo_main_black").resizable()
                    .frame(width: 159, height: 33)
                    .padding(.top, 136)
                    .padding(.horizontal, 108)
                
                HStack(alignment: .center, spacing: 0) {
                    TextField("이메일 주소 입력", text: $email)
                        .font(.T4KrMd)
                        .foregroundColor(.textDisabled)
                        .padding(.leading, 20)
                        .padding(.vertical, 16)
                        .frame(width: 335, alignment: .leading)
                        .background(Color.bgSecondary)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.line200)
                        )
                }
                .padding(.top, 68)
                .padding(.horizontal,20)
                
                HStack(alignment: .center, spacing: 0) {
                    TextField("비밀번호 입력", text: $password)
                        .font(.T4KrMd)
                        .foregroundColor(.textDisabled)
                        .padding(.leading, 20)
                        .padding(.vertical, 16)
                        .frame(width: 335, alignment: .leading)
                        .background(Color.bgSecondary)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.line200)
                        )
                }
                .padding(.top, 8)
                .padding(.horizontal,20)
                
                Button(action:  {
                    
                } , label: {
                    Text("로그인")
                        .font(.But1KrBd)
                        .foregroundColor(.textWhite)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.textBrand)
                        .cornerRadius(20)
                })
                .padding(.horizontal, 20)
                .padding(.top, 68)
                
                NavigationLink(destination: AgreeView().navigationBarBackButtonHidden()) {
                    Text("이메일 가입")
                        .font(.But2KrMd)
                        .foregroundColor(.textSecondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.bgWhite)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView(loginVM: LoginViewModel())
}
