//
//  PreviousCollabView.swift
//  Spon-Us
//
//  Created by KimYuBin on 8/30/24.
//

import SwiftUI

enum ProposalSelection {
    case sent
    case received
}

struct PreviousCollabView: View {
    @State private var selectedProposal: ProposalSelection = .sent
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {
                    selectedProposal = .sent
                }, label: {
                    Text("보낸 제안")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedProposal == .sent ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 147, height: 40)
                })
                .background(selectedProposal == .sent ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
                
                Button(action: {
                    selectedProposal = .received
                }, label: {
                    Text("받은 제안")
                        .korFont(.T4KrBd)
                        .foregroundStyle(selectedProposal == .received ? Color.textPrimary : Color.textDisabled)
                        .frame(width: 147, height: 40)
                })
                .background(selectedProposal == .received ? Color.bgWhite : Color.clear)
                .cornerRadius(12)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 56)
            .background(Color.bgTertiary)
            .cornerRadius(20)
            .padding(.all, 20)
        }
    }
}

#Preview {
    PreviousCollabView()
}
