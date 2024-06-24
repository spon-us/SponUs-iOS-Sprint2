//
//  AgreeView.swift
//  Spon-Us
//
//  Created by 김수민 on 6/24/24.
//

import SwiftUI

struct AgreeView: View {
    @State private var checks = [false, false, false, false]
    @State private var allChecked: Bool = false
    private let agreeTitle: [String] = ["(필수) 개인정보처리방침을 읽고 숙지하였습니다",
                                        "(필수) 개인정보 수집 및 이용 동의",
                                        "(필수) 이용약관 동의",
                                        "(선택) 개인정보 제 3자 제공 동의"]
    
    //MARK: Function
    private func updateAllChecked() {
        allChecked = checks.prefix(3).allSatisfy { $0 }
    }
    
    private func setAllChecks(to value: Bool) {
        checks = checks.map { _ in value }
        allChecked = value
    }
    
    //MARK: View
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("스포너스 이용을 위해\n이용약관에 동의해주세요")
                    .font(.H2KrBd)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .padding(.trailing, 81)
                
                Button(action: {
                    if allChecked {
                        setAllChecks(to: false)
                    } else {
                        setAllChecks(to: true)
                    }
                }, label: {
                    HStack {
                        Image(allChecked ? "Tick Square 3" : "Tick Square 2")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 8)
                        Text("이용약관 전체 동의")
                            .font(.T4KrBd)
                            .foregroundColor(allChecked ? .textBrand : .textDisabled)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.bgWhite)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(allChecked ? Color.textBrand : Color.line200)
                    )
                })
                .padding(.top, 40)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(0..<4, id: \.self) { index in
                        HStack {
                            Button(action: {
                                checks[index].toggle()
                                updateAllChecked()
                            }) {
                                Image(checks[index] ? "Tick Square 3" : "Tick Square 2")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        
                            NavigationLink(destination: DetailAgreeView(selectedIndex: index).navigationBarBackButtonHidden().navigationTitle("개인정보처리방침")
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarItems(leading: CustomBackButton())) {
                                HStack() {
                                    Text(agreeTitle[index])
                                        .font(.B2KrMd)
                                        .foregroundColor(checks[index] ? .textSecondary : .textDisabled)
                                        .padding(.leading, 8)
                                    Spacer()
                                    Image(checks[index] ? "icRight1" : "icRight2")
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 45)
                
                Spacer()
                
                Button(action:  {
                    
                } , label: {
                    Text("다음")
                        .font(.But1KrBd)
                        .foregroundColor(allChecked ? .textWhite : .textDisabled)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(allChecked ? Color.textBrand : Color.bgTertiary)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(allChecked ? Color.textBrand : Color.line200)
                        )
                })
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .background(Color.bgSecondary)
        }
    }
}

#Preview {
    AgreeView()
}

