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
    
    @State var isSecured: Bool = true
    @State var selectedField: Int = 3
    @State var wrongInput: String = ""
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image("logo_main_black").resizable()
                .frame(width: 159, height: 33)
                .padding(.top, 136)
                .padding(.horizontal, 108)
            
            HStack(alignment: .center, spacing: 0) {
                TextField("", text: $email, prompt: Text("이메일 주소 입력").font(.T4KrMd).foregroundColor(.textDisabled))
                    .font(.T4EnMd)
                    .foregroundColor(.textPrimary)
                    .padding(.leading, 20)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.bgSecondary)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(wrongInput == "email" ? Color.statusRed : selectedField == 0 ? Color.textBrand : Color.line200)
                    )
                    .onTapGesture {
                        selectedField = 0
                    }
            }
            .padding(.top, 68)
            .padding(.horizontal,20)
            
            if wrongInput == "email" {
                HStack() {
                    Image("icDanger")
                        .frame(width: 13.33, height: 13.33)
                        .padding(.trailing, 1)
                    Text("이메일을 다시 입력해 주세요.")
                        .font(.B4KrMd)
                        .foregroundColor(Color(red: 1, green: 0, blue: 0)
                        )
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.leading, 24)
            }
            
            HStack(spacing: 0) {
                if isSecured {
                    SecureField("", text: $password, prompt: Text("비밀번호 입력").font(.T4KrMd).foregroundColor(.textDisabled))
                        .frame(maxWidth: .infinity)
                        .font(.T4KrMd)
                        .foregroundColor(.textPrimary)
                        .onTapGesture {
                            selectedField = 1
                        }
                } else {
                    TextField("", text: $password, prompt: Text("비밀번호 입력").font(.T4KrMd).foregroundColor(.textDisabled))
                        .frame(maxWidth: .infinity)
                        .font(.T4EnMd)
                        .foregroundColor(.textPrimary)
                        .onTapGesture {
                            selectedField = 1
                        }
                }
                Spacer()
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.vertical, 16)
            .padding(.leading, 20)
            .padding(.trailing, 16)
            .background(Color.bgSecondary)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        wrongInput == "password" ? Color.statusRed : selectedField == 1 ? Color.textBrand : Color.line200
                    )
            )
            .padding(.top, 8)
            .padding(.horizontal, 20)
            
            Button(action:  {
                loginVM.login(email: email, password: password) { resultContent in
                    switch resultContent {
                    case "success" : 
                        loginVM.loginSuccess = true
                        UserDefaults.standard.set(true, forKey: "isAutoLogin")
//                        TokenManager.shared.isAutoLogin = true
                    case "Account not found": wrongInput = "email"
                    case "Bad credentials": wrongInput = "password"
                    default:
                        return
                    }
                }
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
            
            if wrongInput == "password" {
                HStack() {
                    Image("icDanger")
                        .frame(width: 13.33, height: 13.33)
                        .padding(.trailing, 1)
                    Text("비밀번호를 다시 입력해 주세요.")
                        .font(.B4KrMd)
                        .foregroundColor(Color(red: 1, green: 0, blue: 0)
                        )
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.leading, 24)
            }
            
            NavigationLink(destination: AgreeView().navigationBarHidden(true)) {
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
