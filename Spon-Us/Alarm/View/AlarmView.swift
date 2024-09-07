//
//  AlarmUIView.swift
//  Spon-Us
//
//  Created by 김수민 on 8/30/24.
//

import SwiftUI

enum AlarmColumn {
    case send
    case receive
}

struct AlarmView: View {
    @State var selectedColumn: AlarmColumn = .send
    @ObservedObject private var vm: AlarmViewModel = AlarmViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ColumnView(column: $selectedColumn)
                .frame(height: 56)
                .padding(20)

            if selectedColumn == .send {
                if vm.sendList.count == 0 {
                    EmptyAlarmView()
                } else {
                    SendView(vm: vm)
                }
            } else {
                if vm.receivedList.count == 0 {
                    EmptyAlarmView()
                } else {
                    ReceivedView(vm: vm)
                }
            }
        }.onAppear(perform: vm.onAlarmViewAppear)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {
                    CustomBackButton()
                    CustomNavigationTitle(title: "제안여부")
                }
            }
        }
    }
}

struct ColumnView: View {
    @Binding var column: AlarmColumn
    var body: some View {
        HStack(spacing: 17) {
            Button(action: {column = .send}) {
                Text("보낸 제안")
                    .font(.T4KrBd)
                    .foregroundColor(column == .send ? Color.textPrimary : Color.textDisabled)
                    .padding(.horizontal, 44)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(column == .send ? Color.white : Color.bgTertiary)
                    .cornerRadius(12)
            }
            Button(action: {column = .receive}) {
                Text("받은 제안")
                    .font(.T4KrBd)
                    .foregroundColor(column == .receive ? Color.textPrimary : Color.textDisabled)
                    .padding(.horizontal, 44)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(column == .receive ? Color.white : Color.bgTertiary)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.bgTertiary)
        .cornerRadius(20)
    }
}

enum SendResult {
    case success
    case reject
}


struct SendView: View {
    @ObservedObject var vm: AlarmViewModel
    
    var body: some View {
        ScrollView {
            ForEach(vm.sendList, id: \.id) { list in
                SendAlarmCell(result: list.body == "제안이 수락됐어요" ? .success : .reject, name: list.organizationName, email: "https://gmail.com/", image: list.organizationProfile, isRead: list.isRead)
            }
        }.padding(.horizontal, 20)
    }
}

struct SendAlarmCell: View {
    let result: SendResult
    let name: String
    let email: String?
    let image: String?
    var isRead: Bool
    
    var body: some View {
        if result == .success {
            HStack(alignment: .top, spacing: 0) {
                Image(image ?? "logo_app")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.top, 12)
                    .padding(.trailing, 20)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.B2KrMd)
                        .foregroundColor(.textSecondary)
                    Text("제안이 수락됐어요")
                        .font(.T4KrBd)
                        .foregroundColor(isRead == true ? .textPrimary : .textBrand)
                    Text("이메일을 확인하고 기업과 컨택해 보세요.")
                        .font(.B4KrMd)
                        .foregroundColor(.textTertiary)
                }
                .frame(maxWidth: .infinity)
                Spacer()
                Button(action: {/*이메일 창 이동*/}) {
                    Text("이메일 확인")
                        .font(.B2KrMd)
                        .foregroundColor(.textSecondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.bgTertiary)
                        .cornerRadius(12)
                        .overlay(
                        RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.line200, lineWidth: 1))
                }
                .padding(.top, 18)
            }
        } else {
            HStack(alignment: .top, spacing: 0) {
                Image(image ?? "logo_app")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.top, 12)
                    .padding(.trailing, 20)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.B2KrMd)
                        .foregroundColor(Color.textDisabled)
                    Text("제안이 거절됐어요")
                        .font(.T4KrBd)
                        .foregroundColor(Color.textDisabled)
                }
                .padding(.vertical, 12)
                Spacer()
            }
        }
    }
}
struct ReceivedView: View {
    @ObservedObject var vm: AlarmViewModel
    
    var body: some View {
        ScrollView {
            ForEach(vm.receivedList, id: \.id) { list in
                ReceivedCell(name: list.organizationName, email: "https://gmail.com/", image: list.organizationProfile, isRead: list.isRead)
            }
        }.padding(.horizontal, 20)
    }
}

struct ReceivedCell: View {
    let name: String
    let email: String?
    let image: String?
    var isRead: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(image ?? "logo_app")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.top, 12)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.B2KrMd)
                    .foregroundColor(.textSecondary)
                Text("제안을 받았어요.")
                    .font(.T4KrBd)
                    .foregroundColor(isRead == true ? .textPrimary : .textBrand)
                Text("이메일을 확인하고 기업과 컨택해 보세요.")
                    .font(.B4KrMd)
                    .foregroundColor(.textTertiary)
            }
            .frame(maxWidth: .infinity)
            Spacer()
            Button(action: {/*이메일 창 이동*/}) {
                Text("이메일 확인")
                    .font(.B2KrMd)
                    .foregroundColor(.textSecondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.bgTertiary)
                    .cornerRadius(12)
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color.line200, lineWidth: 1))
            }
            .padding(.top, 18)
        }
    }
}

struct EmptyAlarmView: View {
    var body: some View {
        VStack() {
            Spacer()
            Text("제안 여부가 없어요")
                .font(.T4KrMd)
                .foregroundColor(.textDisabled)
            Spacer()
        }
    }
}
