//
//  WriteCompanyProfileView.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import SwiftUI


enum WriteCompanyProfileTab: String, CaseIterable, Identifiable, TabItem {
    case image = "이미지"
    case name = "이름"
    case collaborationField = "협업 유형"
    case companyField = "기업 분야"
    case link = "공식사이트"
    
    var id: String { self.rawValue }
}

struct WriteCompanyProfileView: View {
    @State private var selectedPage: WriteCompanyProfileTab = .collaborationField
    @State var isPresented = false
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {
                    
                    CompanyImageTabView(selectedPage: $selectedPage)
                        .tag(WriteCompanyProfileTab.image)
                    
                    CompanyNameTabView(selectedPage: $selectedPage)
                        .tag(WriteCompanyProfileTab.name)
                    
                    CompanyCollaborationFieldTabView(selectedPage: $selectedPage)
                        .tag(WriteCompanyProfileTab.collaborationField)
                    
                    CompanyFieldTabView(selectedPage: $selectedPage)
                        .tag(WriteCompanyProfileTab.companyField)
                    
                    CompanyLinkTabView(selectedPage: $selectedPage)
                        .tag(WriteCompanyProfileTab.link)
                    
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

struct CompanyImageTabView: View {
    
    @Binding var selectedPage: WriteCompanyProfileTab
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("기업 이미지를\n첨부해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        isImagePickerPresented.toggle()
                    }, label: {
                        ZStack(alignment: .topTrailing) {
                            
                            HStack(spacing: 0) {
                                Image("Edit")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.textBrand)
                                    .padding(.trailing, 2)
                                
                                Text("첨부하기")
                                    .font(.B2KrBd)
                                    .foregroundStyle(Color.textBrand)
                                
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(Color.bgBrandSecondary)
                            )
                            .padding(.trailing, 16)
                            .padding(.top, 16)
                            .zIndex(1.0)
                            
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 32))

                            } else {
                                RoundedRectangle(cornerRadius: 32)
                                    .inset(by: 0.5)
                                    .fill(Color.bgWhite)
                                    .stroke(Color.line200, lineWidth: 1)
                                    .frame(height: 335)
                            }
                        }
                    })
                    .sheet(isPresented: $isImagePickerPresented) {
                        SingleImagePickerView(selectedImage: $selectedImage)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                selectedPage = .name
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: selectedImage == nil)
            })
            .disabled(selectedImage == nil)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
    }
}

struct CompanyNameTabView: View {
    
    @State var text = ""
    var limitTextCount = 13
    
    @Binding var selectedPage: WriteCompanyProfileTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("기업 이름을\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    TextField("ex. Spon-us", text: $text)
                        .textFieldStyle(SponusTextfieldStyle(text: $text, limitTextCount: limitTextCount))
                        .padding(.bottom, 8)
                    
                    Text("(\(text.count)/\(limitTextCount))")
                        .font(.B2EnMd)
                        .foregroundStyle(Color.textTertiary)
                        .padding(.leading, 12)
                    
                }
                .padding(.horizontal, 20)
            }

            Button(action: {
                selectedPage = .collaborationField
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .disabled(text.count == 0 || text.count > limitTextCount)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)

    }
}

//enum CoworkCategory: String {
//    case linkedProject = "연계프로젝트"
//    case partnership = "제휴"
//    case sponsorship = "협찬"
//}

struct CompanyCollaborationFieldTabView: View {
    
    @State private var number = ""
    @Binding var selectedPage: WriteCompanyProfileTab
    
    var limitTextCount = 999
    
    @State var linkedProjectSelected = false
    @State var partnershipSelected = false
    @State var sponsorshipSelected = false
    @State var sponsorshipSelected2 = false
    
    @State var text = ""
    
    @State private var categories: [CompanyCategorySelection] = CompanyCategory.allCases.dropFirst().map {
        CompanyCategorySelection(category: $0, isSelected: false)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("기업의 희망 협업 유형을\n선택해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    SelectinOptionCell(text: CoworkCategory.linkedProject.rawValue, isSelected: linkedProjectSelected)
                        .onTapGesture {
                            linkedProjectSelected.toggle()
                        }
                        .padding(.bottom, 8)
                    
                    SelectinOptionCell(text: CoworkCategory.partnership.rawValue, isSelected: partnershipSelected)
                        .onTapGesture {
                        partnershipSelected.toggle()
                    }
                        .padding(.bottom, 8)
                    
                    SelectinOptionCell(text: CoworkCategory.sponsorship.rawValue, isSelected: sponsorshipSelected)
                        .onTapGesture {
                            sponsorshipSelected.toggle()
                        }
                        .padding(.bottom, 8)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Image("Tick Square")
                                .renderingMode(.template)
                                .foregroundStyle(sponsorshipSelected2 ? Color.textBrand : Color.textDisabled)
                                .padding(.trailing, 21)
                            
                            Text("협찬")
                                .font(.B2KrMd)
                                .foregroundStyle(Color.textPrimary)
                            
                            Spacer()
                        }
                        .padding(.bottom, 12)
                        
                        TextField("협찬 가능한 대표적인 물품", text: $text)
                    }
                        .padding(.vertical, 14)
                        .padding(.leading, 20)
                        .background(Color.bgWhite)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(sponsorshipSelected2 ? Color.textBrand : Color.line200, lineWidth: 1)
                            
                        )


                    
//                    ForEach($categories) { $category in
//                        SelectinOptionCell(text: category.category.rawValue, isSelected: category.isSelected)
//                            .padding(.bottom, 8)
//                            .onTapGesture {
//                                toggleSelection(for: category)
//                            }
//                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {

            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: isButtonDisabled())
            })
            .disabled(isButtonDisabled())
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
    

    
    private func isButtonDisabled() -> Bool {
        return categories.filter { $0.isSelected }.isEmpty
    }
}

struct CompanyFieldTabView: View {
    @State private var number = ""
    @Binding var selectedPage: WriteCompanyProfileTab
    
    var limitTextCount = 999
    
    let maxSelections = 3
    
    @State private var categories: [CompanyCategorySelection] = CompanyCategory.allCases.dropFirst().map {
        CompanyCategorySelection(category: $0, isSelected: false)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("기업 분야를\n선택해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 4)
                    
                    Text("최대 \(maxSelections)개 선택 가능")
                        .font(.B2KrMd)
                        .foregroundStyle(Color.textDisabled)
                        .padding(.bottom, 24)
                    
                    ForEach($categories) { $category in
                        SelectinOptionCell(text: category.category.rawValue, isSelected: category.isSelected)
                            .padding(.bottom, 8)
                            .onTapGesture {
                                toggleSelection(for: category)
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {

            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: isButtonDisabled())
            })
            .disabled(isButtonDisabled())
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
    
    private func toggleSelection(for category: CompanyCategorySelection) {
        if category.isSelected {
            // If the category is already selected, allow deselecting it
            if let index = categories.firstIndex(where: { $0.id == category.id }) {
                categories[index].isSelected.toggle()
            }
        } else {
            // If the category is not selected, allow selecting it only if the limit has not been reached
            let selectedCount = categories.filter { $0.isSelected }.count
            if selectedCount < maxSelections {
                if let index = categories.firstIndex(where: { $0.id == category.id }) {
                    categories[index].isSelected.toggle()
                }
            }
        }
    }
    
    private func isButtonDisabled() -> Bool {
        return categories.filter { $0.isSelected }.isEmpty
    }
}

struct CompanyLinkTabView: View {
    
    @State private var WebsiteUrl = ""
    
    @Binding var selectedPage: WriteCompanyProfileTab

    
    var limitTextCount = 999
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("기업의 공식사이트를\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 4)
                    
                    Text("공식사이트 입력은 선택사항이에요.")
                        .font(.B2KrMd)
                        .foregroundStyle(Color.textDisabled)
                        .padding(.bottom, 24)
                    
                    
                        
                        TextField("URL 입력", text: $WebsiteUrl)
                            .textFieldStyle(SponusTextfieldStyle(text: $WebsiteUrl, limitTextCount: limitTextCount))
       
                }
                .padding(.horizontal, 20)
            }
            Button(action: {
                    
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: false)
            })
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
}


#Preview {
    WriteCompanyProfileView()
}

