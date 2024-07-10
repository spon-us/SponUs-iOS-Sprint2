//
//  SignUpPWView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/2/24.
//

import SwiftUI

struct SignUpPWView: View {
    @ObservedObject var vm: SignUpViewModel
    @State private var password1: String = ""
    @State private var password2: String = ""
    @State private var passwordValid: Bool = false
    @State private var isSecured1: Bool = true
    @State private var isSecured2: Bool = true
    @State private var selectedField: Int = 0
    @State private var wrongPassword: Bool = false
    @State private var navigate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBackBar()
            
            Text("비밀번호를\n입력해주세요")
                .font(.H2KrBd)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                if isSecured1 {
                    SecureField("비밀번호 입력", text: $password1)
                        .font(.T4KrMd)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedField = 1
                        }
                } else {
                    TextField("", text: $password1, prompt: Text("비밀번호 입력").font(.T4KrMd).foregroundColor(.textDisabled))
                        .font(.T4KrMd)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedField = 1
                        }
                }
                Spacer()
                Button(action: {
                    isSecured1.toggle()
                }) {
                    Image(systemName: self.isSecured1 ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 14)
            .padding(.leading, 20)
            .padding(.trailing, 16)
            .background(Color.bgWhite)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        selectedField == 1 ? Color.textBrand : Color.line200
                    )
            )
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            HStack(spacing: 0) {
                if isSecured2 {
                    SecureField("비밀번호 확인", text: $password2)
                        .font(.T4KrMd)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity)
                        .onChange(of: password2) { _, _ in
                            passwordValid = (password1 == password2)
                        }
                        .onTapGesture {
                            selectedField = 2
                        }
                } else {
                    TextField("", text: $password2, prompt: Text("비밀번호 입력").font(.T4KrMd).foregroundColor(.textDisabled))
                        .font(.T4KrMd)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity)
                        .onChange(of: password2) { _, _ in
                            passwordValid = (password1 == password2)
                        }
                        .onTapGesture {
                            selectedField = 2
                        }
                }
                Button(action: {
                    isSecured2.toggle()
                }) {
                    Image(systemName: self.isSecured2 ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 14)
            .padding(.leading, 20)
            .padding(.trailing, 16)
            .background(Color.bgWhite)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        wrongPassword ? .statusRed : selectedField == 2 ? Color.textBrand : Color.line200
                    )
            )
            .padding(.top, 8)
            .padding(.horizontal, 20)
            
            if wrongPassword {
                HStack() {
                    Image("icDanger")
                        .frame(width: 13.33, height: 13.33)
                        .padding(.trailing, 1)
                    Text("비밀번호가 일치하지 않아요.")
                        .font(.B4KrMd)
                        .foregroundColor(Color(red: 1, green: 0, blue: 0)
                        )
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.leading, 24)
            }

            Spacer()
            
            if !(password1 != "" && password2 != "" && (password1 == password2)) {
                Button(action: {wrongPassword = (password1 != password2)}) {
                    Text("다음")
                        .font(.But1KrBd)
                        .frame(maxWidth: .infinity, maxHeight: 56)
                        .foregroundColor(password1 == "" || password2 == "" ? .textDisabled : .textWhite)
                        .background(password1 == "" || password2 == "" ? Color.bgTertiary : Color.textBrand)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(password1 == "" || password2 == "" ? Color.line200 : Color.textBrand)
                        )
                }
                .disabled(password1 == "" || password2 == "")
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            } else {
                Button(action: {
                    vm.password = password1
                    navigate = true
                }) {
                    Text("다음")
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
        }
        .background(Color.bgSecondary)
        .onTapGesture {
            self.dismissKeyboard()
        }
        
        //MARK: Navigate
        NavigationLink(destination: SignUpOrgView(vm: vm).navigationBarHidden(true), isActive: $navigate) {
            EmptyView()
        }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
