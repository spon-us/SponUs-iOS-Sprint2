//
//  WriteProfileView.swift
//  Spon-Us
//
//  Created by 황인성 on 6/22/24.
//

import SwiftUI
import Combine

enum WriteProfileTab: String, CaseIterable, Identifiable, TabItem {
    case image = "이미지"
    case name = "이름"
    case introduce = "소개"
    case member = "회원 수"
    case link = "링크"
    case field = "분야"
    
    var id: String { self.rawValue }
}

struct WriteProfileView: View {
    
    @State private var selectedPage: WriteProfileTab = .image
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                    .background(Color.bgSecondary)
                
                TabView(selection: $selectedPage) {
                    
                    ImageTabView(selectedPage: $selectedPage)
                        .tag(WriteProfileTab.image)
                    
                    NameTabView(selectedPage: $selectedPage)
                        .tag(WriteProfileTab.name)
                    
                    IntroduceTabView(selectedPage: $selectedPage)
                        .tag(WriteProfileTab.introduce)
                    
                    MemberTabView(selectedPage: $selectedPage)
                        .tag(WriteProfileTab.member)
                    
                    LinkTabView(selectedPage: $selectedPage)
                        .tag(WriteProfileTab.link)
                    
                    FieldTabView()
                        .tag(WriteProfileTab.field)
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
        }
        
    }
}

struct WriteProfileTopTabBar: View {
    
    @Binding var selectedPage: WriteProfileTab
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                
                ForEach(WriteProfileTab.allCases, id: \.self) { category in
                    
                    Text(category.rawValue)
                        .font(.B1KrMd)
                        .foregroundColor(category.rawValue == selectedPage.rawValue ? Color.textBrand : Color.textDisabled)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 999)
                                .inset(by: 0.5)
                                .fill(Color.bgWhite)
                                .stroke(category.rawValue == selectedPage.rawValue ? Color.textBrand : Color.line200, lineWidth: 1)
                            
                        )
                        .onTapGesture {
                            selectedPage = category
                        }
                    
                }
                
            }
            .padding(.leading, 20)
            .padding(.vertical, 1)
        }
        .scrollIndicators(.hidden)
    }
}

struct ImageTabView: View {
    
    @Binding var selectedPage: WriteProfileTab
    
    @State private var selectedImages: [UIImage] = []
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("동아리 이미지를\n첨부해 주세요")
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
                            
                            if selectedImages.isEmpty {
                                RoundedRectangle(cornerRadius: 32)
                                    .inset(by: 0.5)
                                    .fill(Color.bgWhite)
                                    .stroke(Color.line200, lineWidth: 1)
                                    .frame(height: 335)
                            }
                            else {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle(cornerRadius: 32))

                                }
                            }
                        }
                    })
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePickerView(selectedImages: $selectedImages, selectedImageCount: .single)
                    }
                    
                    

                    
                    
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                selectedPage = .name
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: selectedImages.isEmpty)
            })
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
    }
}

struct NameTabView: View {
    
    @State var text = ""
    var limitTextCount = 13
    
    @Binding var selectedPage: WriteProfileTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("동아리 이름을\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    TextField("ex. 스포너스 기획 동아리", text: $text)
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
                selectedPage = .introduce
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)

    }
}

struct IntroduceTabView: View {
    
    @State var text = ""
    var limitTextCount = 300
    
    @Binding var selectedPage: WriteProfileTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("동아리 소개를\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    TextEditor(text: $text)
                        .modifier(SponusTextEditorModifier(text: $text, limitTextCount: limitTextCount, height: 260, placeHolder: "ex. 안녕하세요. 저희는 스포대학교의 마케팅 기획을 하는 동아리 ‘스포대학교' 기획동아리 입니다."))
                        .padding(.bottom, 8)
                    
                    HStack(spacing: 0) {
                        
                        Text("(\(text.count)/\(limitTextCount))")
                            .font(.B2EnMd)
                            .foregroundStyle(Color.textTertiary)
                        
                        Spacer()
                        
                        Button(action: {
                            text = ""
                        }, label: {
                            Text("전체 삭제")
                                .font(.B2EnMd)
                                .foregroundStyle(Color.textTertiary)
                            
                        })
                        
                    }
                    .padding(.horizontal, 12)
                    
                }
                .padding(.horizontal, 20)
            }
        
            Button(action: {
                selectedPage = .member
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)

    }
}

struct MemberTabView: View {
    
    @State private var number = ""
    var limitTextCount = 999
    
    @Binding var selectedPage: WriteProfileTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("동아리 회원 수를\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    TextField("ex. 999", text: $number)
                        .keyboardType(.numberPad)
                        .onReceive(Just(number)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.number = filtered
                            }
                        }
                        .textFieldStyle(SponusTextfieldStyle(text: $number, limitTextCount: limitTextCount))
                        .padding(.bottom, 8)
       
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                selectedPage = .link
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: isButtonDisabled())
                    .padding(.horizontal, 20)
                
            })
            
        }
        .background(Color.bgSecondary)
    }
    
    private func isButtonDisabled() -> Bool {
        guard let numberValue = Int(number), numberValue > 0 else {
            return true
        }
        return false
    }
}

struct LinkTabView: View {
    
    @State private var instagramUrl = ""
    @State private var facebookUrl = ""
    @State private var WebsiteUrl = ""
    
    @Binding var selectedPage: WriteProfileTab
    
    var limitTextCount = 999
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("동아리 링크를\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 4)
                    
                    Text("링크 입력은 선택사항이에요.")
                        .font(.B2KrMd)
                        .foregroundStyle(Color.textDisabled)
                        .padding(.bottom, 24)
                    
                    HStack(spacing: 12) {
                        Image("instagram")
                        
                        TextField("URL 입력", text: $instagramUrl)
                            .textFieldStyle(SponusTextfieldStyle(text: $instagramUrl, limitTextCount: limitTextCount))
                    }
                    .padding(.bottom, 8)
                    
                    HStack(spacing: 12) {
                        Image("facebook")
                        
                        TextField("URL 입력", text: $facebookUrl)
                            .textFieldStyle(SponusTextfieldStyle(text: $facebookUrl, limitTextCount: limitTextCount))
                    }
                    .padding(.bottom, 8)
                    
                    HStack(spacing: 12) {
                        Image("website")
                        
                        TextField("URL 입력", text: $WebsiteUrl)
                            .textFieldStyle(SponusTextfieldStyle(text: $WebsiteUrl, limitTextCount: limitTextCount))
                    }
                    .padding(.bottom, 8)
       
                }
                .padding(.horizontal, 20)
            }
            Button(action: {
                selectedPage = .field
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: false)
            })
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
}

struct FieldTabView: View {
    @State private var number = ""
    var limitTextCount = 999
    
    let maxSelections = 2
    
    @State private var categories: [CategorySelection] = ClubCategory.allCases.dropFirst().map {
            CategorySelection(category: $0, isSelected: false)
        }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("동아리 분야를\n입력해 주세요")
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
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
    
    private func toggleSelection(for category: CategorySelection) {
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

struct SponusTextEditorModifier: ViewModifier {
    
    @Binding var text: String
    var limitTextCount: Int
    var height: CGFloat
    var placeHolder: String
    
    @State private var isEditing = false // 추가: 편집 중인지 여부를 추적하기 위한 상태 변수
    
    func body(content: Content) -> some View {
        
        ZStack(alignment: .top) {
            
            // placeholder를 터치하면 isEditing을 true로 설정
            
            if text.isEmpty && !isEditing {
                Text(placeHolder)
                    .font(.T4KrMd)
                    .foregroundStyle(Color.textDisabled)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .zIndex(1.0)
            }
//                .opacity(text.isEmpty && !isEditing ? 1.0 : 0) // 텍스트가 비어 있고 편집 중이 아니면 표시
            
            content
                .font(.T4KrMd)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, minHeight: height)
                .background(Color.white)
                .cornerRadius(16)
                .overlay(
                    Group{
                        if text.isEmpty {
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color.line200, lineWidth: 1)
                        }
                        else {
                                RoundedRectangle(cornerRadius: 16)
                                    .inset(by: 0.5)
                                    .stroke(text.count <= limitTextCount ? Color.textBrand : Color.red, lineWidth: 1)
                        }
                    }
                )
                .onTapGesture {
                    isEditing = true // 텍스트 편집기를 탭하면 편집 중으로 설정
                }
                .onDisappear {
                    isEditing = false // 뷰가 사라지면 편집 상태 초기화
                }
        }
    }
}


struct SponusTextfieldStyle: TextFieldStyle {
    
    @Binding var text: String
    var limitTextCount: Int
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            
            if !text.isEmpty {
                
                Button(action: {
                    text = ""
                }, label: {
                    Image("icCancel")
                })
                .padding(.trailing, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .zIndex(1.0)
            }
            
            configuration
                .font(.T4KrBd)
                .padding(.vertical, 20)
                .padding(.leading, 20)
                .padding(.trailing, 45)
                .background(Color.bgWhite)
                .cornerRadius(16)
                .overlay(
                    Group{
                        if text.isEmpty {
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color.line200, lineWidth: 1)
                        }
                        else {
                                RoundedRectangle(cornerRadius: 16)
                                    .inset(by: 0.5)
                                    .stroke(text.count <= limitTextCount ? Color.textBrand : Color.red, lineWidth: 1)
                        }
                    }
                )
        }
        
    }
}

#Preview {
    WriteProfileView()
}

#Preview {
    CompleteView()
}



struct SelectinOptionCell: View {
    
    var text: String
    var isSelected: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Image("Tick Square")
                .renderingMode(.template)
                .foregroundStyle(isSelected ? Color.textBrand : Color.textDisabled)
                .padding(.trailing, 21)
            
            Text(text)
                .font(.B2KrMd)
                .foregroundStyle(Color.textPrimary)
            
            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.leading, 20)
        .background(Color.bgWhite)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(isSelected ? Color.textBrand : Color.line200, lineWidth: 1)
            
        )
    }
}

struct CategorySelection: Identifiable {
    var id = UUID()
    var category: ClubCategory
    var isSelected: Bool
}

struct CompleteView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Image("113.check")
                .padding(.bottom, 16)
                .padding(.top, 74)
            
            Text("프로필 입력이\n완료 되었어요")
                .font(.H2KrBd)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textPrimary)
                .padding(.bottom, 4)
            
            Text("포트폴리오를 추가로 업데이트하면\n매칭 성사율이 높아져요!")
                .font(.B2KrMd)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textTertiary)
                
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("홈으로 가기")
                    .font(.But1KrBd)
                    .foregroundStyle(Color.textWhite)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.textBrand)
                    )
            })
            .padding(.bottom, 12)
            
            Button(action: {
                
            }, label: {
                Text("포트폴리오 작성하기")
                    .font(.But1KrBd)
                    .foregroundStyle(Color.textBrand)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.bgBrandSecondary)
                    )
            })
            
            
            
            
            
        }
        .padding(.horizontal, 20)
    }
}
