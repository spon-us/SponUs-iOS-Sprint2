//
//  WriteClubProfileView.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import SwiftUI
import Combine

enum WriteClubProfileTab: String, CaseIterable, Identifiable, TabItem {
    case image = "이미지"
    case name = "이름"
    case introduce = "소개"
    case member = "회원 수"
    case link = "링크"
    case field = "분야"
    
    var id: String { self.rawValue }
}

struct WriteClubProfileView: View {
    
    @State private var selectedPage: WriteClubProfileTab = .image
    @State var isPresented = false
    
    @StateObject var writeClubProfileVM = WriteClubProfileViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {
                    
                    ImageTabView(selectedPage: $selectedPage, WriteClubProfileVM: writeClubProfileVM)
                        .tag(WriteClubProfileTab.image)
                    
                    NameTabView(selectedPage: $selectedPage, writeClubProfileVM: writeClubProfileVM)
                        .tag(WriteClubProfileTab.name)
                    
                    IntroduceTabView(selectedPage: $selectedPage, WriteClubProfileVM: writeClubProfileVM)
                        .tag(WriteClubProfileTab.introduce)
                    
                    MemberTabView(selectedPage: $selectedPage, WriteClubProfileVM: writeClubProfileVM)
                        .tag(WriteClubProfileTab.member)
                    
                    LinkTabView(selectedPage: $selectedPage, WriteClubProfileVM: writeClubProfileVM)
                        .tag(WriteClubProfileTab.link)
                    
                    FieldTabView(WriteClubProfileVM: writeClubProfileVM)
                        .tag(WriteClubProfileTab.field)
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {

                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(.icRight)
                            .renderingMode(.template)
                            .scaleEffect(x: -1, y: 1)
                            .foregroundStyle(Color.textBrand)
                    })
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            WriteCancleModal()
                .presentationDetents( [.height(310.69)] )
                .presentationCornerRadius(32)
                .presentationDragIndicator(.hidden)
        }
        
    }
}


struct ImageTabView: View {
    
    @Binding var selectedPage: WriteClubProfileTab
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    @ObservedObject var WriteClubProfileVM: WriteClubProfileViewModel
    
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
                print(selectedImage)
                WriteClubProfileVM.addClubProfileImage(image: selectedImage ?? UIImage(systemName: "photo")!)
                print(WriteClubProfileVM.clubProfile?.image)
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

// Note: ImagePickerView should be updated to handle a single image selection and to bind it to a single UIImage instead of an array of UIImages.


struct NameTabView: View {
    
    @State var text = ""
    var limitTextCount = 13
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var writeClubProfileVM: WriteClubProfileViewModel
    
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
                print(text)
                writeClubProfileVM.addClubProfileName(name: text)
                print(writeClubProfileVM.clubProfile?.name)
                selectedPage = .introduce
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .disabled(text.count == 0 || text.count > limitTextCount)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)

    }
}

struct IntroduceTabView: View {
    
    @State var text = ""
    var limitTextCount = 300
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var WriteClubProfileVM: WriteClubProfileViewModel

    
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
                WriteClubProfileVM.addClubProfileIntroduce(introduce: text)
                print(WriteClubProfileVM.clubProfile?.introduce)
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .disabled(text.count == 0 || text.count > limitTextCount)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)

    }
}

struct MemberTabView: View {
    
    @State private var number = ""
    var limitTextCount = 999
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var WriteClubProfileVM: WriteClubProfileViewModel

    
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
                WriteClubProfileVM.addClubProfileMember(member: Int(number) ?? 999)
                print(WriteClubProfileVM.clubProfile?.member)
                selectedPage = .link
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: isButtonDisabled())
            })
            .disabled(isButtonDisabled())
            .padding(.horizontal, 20)
            
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
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var WriteClubProfileVM: WriteClubProfileViewModel

    
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
                WriteClubProfileVM.addClubProfileLink(link: Link(instagram: instagramUrl, facebook: facebookUrl, website: WebsiteUrl))
                print(WriteClubProfileVM.clubProfile?.link)
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
    @ObservedObject var WriteClubProfileVM: WriteClubProfileViewModel
    
    @State private var categories: [ClubCategorySelection] = ClubCategory.allCases.dropFirst().map {
        ClubCategorySelection(category: $0, isSelected: false)
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
                let selectedCategories = categories.filter { $0.isSelected }.map { $0.category.rawValue }
                WriteClubProfileVM.addClubProfileField(fields: selectedCategories)
                print(WriteClubProfileVM.clubProfile?.fields)
            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: isButtonDisabled())
            })
            .disabled(isButtonDisabled())
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }
    
    private func toggleSelection(for category: ClubCategorySelection) {
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


#Preview {
    WriteClubProfileView()
}
