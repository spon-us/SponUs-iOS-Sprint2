//
//  SignUpIdView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/2/24.
//

import SwiftUI

struct SignUpIdView: View {
    //MARK: State Property
    @State private var id: String = ""
    @State private var idValid: Bool = false
    @State private var idEmpty: Bool = true
    @State private var isTimerRunning = false
    @State private var timeRemaining = 0
    
    //MARK: Property
    private let emailRegexPattern = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //MARK: View
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBackBar()
            Text("아이디로 사용할\n이메일 주소를 입력해 주세요")
                .font(.H2KrBd)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                TextField("", text: $id, prompt: Text("이메일 주소 입력").font(.T4KrMd).foregroundColor(.textDisabled))
                    .font(.T4KrMd)
                    .foregroundColor(.textPrimary)
                    .frame(maxWidth: .infinity)
                    .onChange(of: id) { newValue in
                        idValid = isValidEmail(id)
                        idEmpty = {return id == ""}()
                    }
                Button(action: {
                    id = ""
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
                    .stroke(
                        idEmpty ? Color.line200 : (!idValid ? .statusRed : Color.textBrand)
                    )
            )
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            if idEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    Text("협업 관련 알림 이메일 발송을 위해 개인 이메일이 아닌").foregroundColor(.textTertiary).font(.B4KrMd)
                    HStack(spacing: 0) {
                        Text("단체 이메일").foregroundColor(.textBrand).font(.B4KrMd)
                        Text("을 사용하시는 것을 권장드려요.").foregroundColor(.textTertiary).font(.B4KrMd)
                    }
                }
                .padding(.top, 16)
                .padding(.leading, 24)
            } else {
                if idValid {
                    HStack() {
                        Image("Tick Square 3")
                            .frame(width: 13.33, height: 13.33)
                            .padding(.trailing, 1)
                        Text("사용 가능한 이메일이에요.")
                            .font(.B4KrMd)
                            .foregroundColor(.textBrand)
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.leading, 24)
                } else {
                    HStack() {
                        Image("icDanger")
                            .frame(width: 13.33, height: 13.33)
                            .padding(.trailing, 1)
                        Text("올바른 형식의 이메일을 작성해 주세요.")
                            .font(.B4KrMd)
                            .foregroundColor(Color(red: 1, green: 0, blue: 0)
                                             )
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.leading, 24)
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("다음")
                    .font(.But1KrBd)
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .foregroundColor(!idEmpty ? .textWhite : .textDisabled)
                    .background(!idEmpty ? Color.textBrand : Color.bgTertiary)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(!idEmpty ? Color.textBrand : Color.line200)
                    )
            }
            .disabled(!idValid)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.bgSecondary)
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
    
    //MARK: Function
    private func isValidEmail(_ email: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)
        return predicate.evaluate(with: email)
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func startTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            timeRemaining = 300
        }
    }
    
    private func stopTimer() {
        isTimerRunning = false
        timeRemaining = 0
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d분 %02d초", minutes, remainingSeconds)
    }
}
