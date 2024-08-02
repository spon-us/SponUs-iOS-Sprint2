//
//  SignUpOrgView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/3/24.
//

import SwiftUI

struct SignUpOrgView: View {
    @State private var navigate: Bool = false
    @State private var selectedOrgType: String =  ""
    
    @ObservedObject var vm: SignUpViewModel
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBackBar()
            
            Text("해당하는 단체를\n선택해주세요")
                .font(.H2KrBd)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.leading, 20)
            
            HStack() {
                Button(action: {selectedOrgType = "CLUB"}) {
                    VStack() {
                        Image("CLUB")
                            .resizable()
                            .frame(width: 64, height: 64)
                        Text("대학생 단체")
                            .font(.T4KrBd)
                            .foregroundColor(.textPrimary)
                    }
                    .padding(.horizontal, 46)
                    .padding(.vertical, 50)
                    .background(Color.bgWhite)
                    .cornerRadius(16)
                    .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedOrgType == "CLUB" ? Color.textBrand :  Color.line200, lineWidth: 2)
                    )
                }
                
                Button(action: {selectedOrgType = "COMPANY"}) {
                    VStack() {
                        Image("ORGANIZATION")
                            .resizable()
                            .frame(width: 64, height: 64)
                        Text("기업 담당자")
                            .font(.T4KrBd)
                            .foregroundColor(.textPrimary)
                    }
                    .padding(.horizontal, 46)
                    .padding(.vertical, 50)
                    .background(Color.bgWhite)
                    .cornerRadius(16)
                    .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedOrgType == "COMPANY" ? Color.textBrand :  Color.line200, lineWidth: 2)
                    )
                }
            }
            .padding(.top, 44)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: {
                vm.organizationType = selectedOrgType
                navigate = true
            }) {
                Text("다음")
                    .font(.But1KrBd)
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .foregroundColor(selectedOrgType == "" ? .textDisabled : .textWhite)
                    .background(selectedOrgType == "" ? Color.bgTertiary :  Color.textBrand)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(selectedOrgType == "" ? Color.line200 : Color.textBrand)
                    )
            }
            .disabled(selectedOrgType == "")
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color.bgSecondary)
        
        //MARK: Navigate
        NavigationLink(destination: SignUpNameView(vm: vm).navigationBarHidden(true), isActive: $navigate) {
            EmptyView()
        }
    }
}

#Preview {
    SignUpOrgView(vm: SignUpViewModel())
}
