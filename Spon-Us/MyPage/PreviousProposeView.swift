//
//  PreviousProposeView.swift
//  Spon-Us
//
//  Created by KimYuBin on 8/30/24.
//

import SwiftUI

enum ProposalSelection {
    case send
    case receive
}

struct PreviousProposeView: View {
    @State private var selectedProposal: ProposalSelection = .send
    @StateObject private var proposeListViewModel = PreviousProposeListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    selectedProposal = .send
                    proposeListViewModel.fetchProposesSend { _ in }
                }, label: {
                    Text("보낸 제안")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedProposal == .send ? Color.textPrimary : Color.textDisabled)
                        .padding(.horizontal, 44)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                .background(selectedProposal == .send ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
                
                Button(action: {
                    selectedProposal = .receive
                    proposeListViewModel.fetchProposesReceive { _ in }
                }, label: {
                    Text("받은 제안")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedProposal == .receive ? Color.textPrimary : Color.textDisabled)
                        .padding(.horizontal, 44)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                .background(selectedProposal == .receive ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 56)
            .background(Color.bgTertiary)
            .cornerRadius(20)
            .padding(.all, 20)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(proposeListViewModel.proposeList) { propose in
                        HStack {
                            if let imageURL = propose.targetImageUrl, let url = URL(string: imageURL) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image(.logoApp)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.line200, lineWidth: 1)
                                )
                            } else {
                                Image(.logoApp)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 44, height: 44)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.line200, lineWidth: 1)
                                    )
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(formatDate(propose.createdAt))
                                    .korFont(.B2KrMd)
                                    .foregroundStyle(Color.textTertiary)
                                
                                Text(propose.targetName)
                                    .korFont(.T4KrBd)
                                    .foregroundStyle(Color.textPrimary)
                                    .padding(.top, 2)
                            }
                            .padding(.leading, 8)
                            
                            Spacer()
                            
                            Text(getStatusText(propose.status, proposalType: selectedProposal))
                                .korFont(.B2KrBd)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(getStatusBackgroundColor(propose.status))
                                .foregroundColor(getStatusForegroundColor(propose.status))
                                .cornerRadius(12)
                        }
                        .padding(.all, 20)
                        .background(Color.bgWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.line200, lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                    }
                }
            }
            .onAppear {
                proposeListViewModel.fetchProposesSend { _ in }
            }
            
            Spacer()
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "yyyy년 M월 d일"
            return formatter.string(from: date)
        }
        return dateString
    }
    
    func getStatusText(_ status: String, proposalType: ProposalSelection) -> String {
        switch (status, proposalType) {
        case ("ACCEPTED", .send):
            return "수락됨"
        case ("REJECTED", .send):
            return "거절됨"
        case ("WAITING", .send):
            return "대기중"
        case ("ACCEPTED", .receive):
            return "수락함"
        case ("REJECTED", .receive):
            return "거절함"
        case ("WAITING", .receive):
            return "대기중"
        default:
            return "알 수 없음"
        }
    }
    
    func getStatusBackgroundColor(_ status: String) -> Color {
        switch status {
        case "ACCEPTED":
            return Color.bgBrandSecondary
        case "REJECTED":
            return Color.statusRedSub
        case "WAITING":
            return Color.statusGreenSub
        default:
            return Color.gray
        }
    }
    
    func getStatusForegroundColor(_ status: String) -> Color {
        switch status {
        case "ACCEPTED":
            return Color.textBrand
        case "REJECTED":
            return Color.statusRed
        case "WAITING":
            return Color.statusGreen
        default:
            return Color.black
        }
    }
}

#Preview {
    PreviousProposeView()
}
