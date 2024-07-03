//
//  SignUpNameView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/3/24.
//

import SwiftUI

struct SignUpNameView: View {
    @ObservedObject var vm: SignUpViewModel
    @State var name: String = ""
    @State var navigate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBackBar()
            
            Text("단체의 이름을\n입력해주세요")
                .font(.H2KrBd)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                TextField("", text: $name, prompt: Text("ex. 스포너스").font(.T4KrMd).foregroundColor(.textDisabled))
                    .font(.T4KrMd)
                    .foregroundColor(.textPrimary)
                    .frame(maxWidth: .infinity)
                Button(action: {
                    name = ""
                }) {
                    Image("icCancel").resizable().frame(width: 20, height: 20)
                }
                .padding(.leading, 20)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(Color.bgWhite)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.line200)
            )
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: {
                vm.name = name
                vm.signUp{ success in
                    if success {
                        navigate = true
                    } else {
                        print("🚨 회원가입 api 네트워크 실패")
                    }
                }
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
        .background(Color.bgSecondary)
        
        //MARK: Navigate
        NavigationLink(destination: SuccessSignUpView().navigationBarHidden(true), isActive: $navigate) {
            EmptyView()
        }
    }
}

#Preview {
    SignUpNameView(vm: SignUpViewModel())
}
