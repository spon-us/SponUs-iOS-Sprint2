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
    @State private var selectedPage: WriteCompanyProfileTab = .image
    @State var isPresented = false
    
    @State var imageTabDiabled = true
    
    @State var buttonDisabled: [WriteCompanyProfileTab : Bool] = [.image : true, .name : true, .collaborationField : true, .companyField : true, .link : true]
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {
                    
                    CompanyImageTabView(selectedPage: $selectedPage, imageTabDisabled: $imageTabDiabled, buttonDisabled: $buttonDisabled)
                        .tag(WriteCompanyProfileTab.image)
                    
                    CompanyNameTabView(selectedPage: $selectedPage, buttonDisabled: $buttonDisabled)
                        .tag(WriteCompanyProfileTab.name)
                    
                    CompanyCollaborationFieldTabView(selectedPage: $selectedPage, buttonDisabled: $buttonDisabled)
                        .tag(WriteCompanyProfileTab.collaborationField)
                    
                    CompanyFieldTabView(selectedPage: $selectedPage, buttonDisabled: $buttonDisabled)
                        .tag(WriteCompanyProfileTab.companyField)
                    
                    CompanyLinkTabView(selectedPage: $selectedPage, buttonDisabled: $buttonDisabled)
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
    
    @Binding var imageTabDisabled: Bool
    @Binding var buttonDisabled: [WriteCompanyProfileTab : Bool]
    
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
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.image]!)
            })
            .disabled(buttonDisabled[.image]!)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
        .onChange(of: selectedImage) {
            if selectedImage == nil {
                buttonDisabled[.image] = true
                print(buttonDisabled[.image]!)
            }
            else {
                buttonDisabled[.image] = false
                print(buttonDisabled[.image]!)
            }
        }
    }
}

struct CompanyNameTabView: View {
    
    @State var text = ""
    var limitTextCount = 13
    
    @Binding var selectedPage: WriteCompanyProfileTab
    @Binding var buttonDisabled: [WriteCompanyProfileTab : Bool]
    
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
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.name]!)
            })
            .disabled(buttonDisabled[.name]!)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onChange(of: text) {
            if text.count == 0 || text.count > limitTextCount {
                buttonDisabled[.name] = true
                print(buttonDisabled[.name]!)
            }
            else {
                buttonDisabled[.name] = false
                print(buttonDisabled[.name]!)
            }
        }
    }
}



struct CompanyCollaborationFieldTabView: View {
    
    @State private var number = ""
    @Binding var selectedPage: WriteCompanyProfileTab
    
    var limitTextCount = 999
    
    @State var linkedProjectSelected = false
    @State var partnershipSelected = false
    @State var sponsorshipSelected = false
    @State var sponsorshipSelected2 = false
    
    
    @State var selectedCategories: [String] = []
    @State var sponsorshipContent = ""
    
    @Binding var buttonDisabled: [WriteCompanyProfileTab : Bool]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Button(action: {
                        print(selectedCategories)
                        print(sponsorshipContent)
                    }, label: {
                        Text("선택된 유형 추가")
                    })
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("기업의 희망 협업 유형을\n선택해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    SelectinOptionCell(text: CoworkCategory.linkedProject.rawValue, isSelected: selectedCategories.contains(CoworkCategory.linkedProject.rawValue))
                        .onTapGesture {
                            if selectedCategories.contains(CoworkCategory.linkedProject.rawValue) {
                                selectedCategories.removeAll { $0 == CoworkCategory.linkedProject.rawValue }
                            } else {
                                selectedCategories.append(CoworkCategory.linkedProject.rawValue)
                            }
                        }
                        .padding(.bottom, 8)
                    
                    SelectinOptionCell(text: CoworkCategory.partnership.rawValue, isSelected: selectedCategories.contains(CoworkCategory.partnership.rawValue))
                        .onTapGesture {
                            if selectedCategories.contains(CoworkCategory.partnership.rawValue) {
                                selectedCategories.removeAll { $0 == CoworkCategory.partnership.rawValue }
                            } else {
                                selectedCategories.append(CoworkCategory.partnership.rawValue)
                            }
                        }
                        .padding(.bottom, 8)
                    
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Image("Tick Square")
                                .renderingMode(.template)
                                .foregroundStyle(selectedCategories.contains(CoworkCategory.sponsorship.rawValue) ? Color.textBrand : Color.textDisabled)
                                .padding(.trailing, 21)
                            
                            Text("협찬")
                                .font(.B2KrMd)
                                .foregroundStyle(Color.textPrimary)
                            
                            Spacer()
                        }
                        .padding(.bottom, 12)
                        .onTapGesture {
                            if selectedCategories.contains(CoworkCategory.sponsorship.rawValue) {
                                selectedCategories.removeAll { $0 == CoworkCategory.sponsorship.rawValue }
                                sponsorshipContent = ""
                            } else {
                                selectedCategories.append(CoworkCategory.sponsorship.rawValue)
                            }
                        }
                        
                        if selectedCategories.contains(CoworkCategory.sponsorship.rawValue) {
                            TextField("협찬 가능한 대표적인 물품", text: $sponsorshipContent)
                                .padding(.bottom, 14)
                        }
                            
                    }
                        .padding(.top, 14)
                        .padding(.leading, 20)
                        .background(Color.bgWhite)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(selectedCategories.contains(CoworkCategory.sponsorship.rawValue) ? Color.textBrand : Color.line200, lineWidth: 1)
                        )

                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {

            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: selectedCategories.isEmpty || (selectedCategories.contains(CoworkCategory.sponsorship.rawValue) && sponsorshipContent.isEmpty))
            })
            .disabled(selectedCategories.isEmpty || (selectedCategories.contains(CoworkCategory.sponsorship.rawValue) && sponsorshipContent.isEmpty))
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onChange(of: selectedCategories) {
            if selectedCategories.isEmpty {
                buttonDisabled[.collaborationField] = true
            }
            else {
                buttonDisabled[.collaborationField] = false
                print(buttonDisabled[.companyField]!)
            }
        }
    }
    

    
//    private func isButtonDisabled() -> Bool {
//        return categories.filter { $0.isSelected }.isEmpty
//    }
}

struct CompanyFieldTabView: View {
    @Binding var selectedPage: WriteCompanyProfileTab
    
    var limitTextCount = 999
    
    let maxSelections = 3
    
    @Binding var buttonDisabled: [WriteCompanyProfileTab : Bool]
    
    var categories: [String] = CompanyCategory.allCases.dropFirst().map { $0.rawValue }
    @State var selectedCategories: [String] = []
    
    var body: some View {
        VStack(spacing: 0) {
            
            Button(action: {
                print(categories)
            }, label: {
                Text("카테고리 출력")
            })
            
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
                    

                    ForEach(categories, id: \.self) { category in
                        SelectinOptionCell(
                            text: category,
                            isSelected: selectedCategories.contains(category)
                        )
                        .padding(.bottom, 8)
                        .onTapGesture {
                            if selectedCategories.contains(category) {
                                // 카테고리가 선택된 상태라면 배열에서 제거
                                selectedCategories.removeAll { $0 == category }
                            } else if selectedCategories.count < maxSelections {
                                // 카테고리가 선택되지 않았고, 최대 선택 수를 넘지 않았을 때만 추가
                                selectedCategories.append(category)
                            }
                            // 선택된 항목이 최대치에 도달한 경우, 아무 동작도 하지 않음
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {

            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: buttonDisabled[.companyField]!)
            })
            .disabled(buttonDisabled[.companyField]!)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onChange(of: selectedCategories) {
            if selectedCategories.isEmpty {
                buttonDisabled[.companyField] = true
                print(buttonDisabled[.companyField]!)
            }
            else {
                buttonDisabled[.companyField] = false
                print(buttonDisabled[.companyField]!)
            }
        }
    }
}

struct CompanyLinkTabView: View {
    
    @State private var WebsiteUrl = ""
    
    @Binding var selectedPage: WriteCompanyProfileTab
    
    @Binding var buttonDisabled: [WriteCompanyProfileTab : Bool]

    
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
                print(buttonDisabled[.image])
                print(buttonDisabled[.name])
                print(buttonDisabled[.collaborationField])
                print(buttonDisabled[.companyField])
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.image]! || buttonDisabled[.name]! || buttonDisabled[.collaborationField]! || buttonDisabled[.companyField]!)
            })
            .disabled(buttonDisabled[.image]! || buttonDisabled[.name]! || buttonDisabled[.collaborationField]! || buttonDisabled[.companyField]!)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
}


#Preview {
    WriteCompanyProfileView()
}

