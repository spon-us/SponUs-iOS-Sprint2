//
//  WriteCompanyProfileView.swift
//  Spon-Us
//
//  Created by 황인성 on 6/26/24.
//

import SwiftUI


enum WriteCompanyProfileTab: String, CaseIterable, Identifiable, TabItem {
    case image = "이미지"
    case name = "이름"
    case collaborationField = "협업 유형"
    case companySector = "기업 분야"
    case link = "공식사이트"
    
    var id: String { self.rawValue }
}

struct WriteCompanyProfileView: View {
    @State private var selectedPage: WriteCompanyProfileTab = .image
    @State var isPresented = false
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {

                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {
                    CustomBackButton()

                }
            }
        }
    }
}


#Preview {
    WriteCompanyProfileView()
}
