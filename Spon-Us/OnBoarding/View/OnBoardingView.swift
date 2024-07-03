//
//  OnBoardingView.swift
//  Spon-Us
//
//  Created by 김수민 on 6/23/24.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationView {
            ZStack() {
                Image("onBoarding")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Image("logo_main").resizable().frame(width: 159, height:33).padding(.top, 136)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("기업과 대학생이").font(.H3KrRr)
                            Text("만나는 자리,").font(.H3KrRr)
                            Text("회원님 환영합니다").font(.H3KrBd)
                                .padding(.top, 8)
                        }
                        .padding(.leading, 20)
                        .foregroundStyle(.white)
                        Spacer()
                    }.padding(.bottom, 80).padding(.top, 296)
                    NavigationLink (destination: LoginView(loginVM: LoginViewModel()).navigationBarBackButtonHidden()){
                        Text("시작하기")
                            .font(.But1KrBd)
                            .foregroundColor(.textWhite)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.textBrand)
                            .cornerRadius(20)
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    
                }
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
