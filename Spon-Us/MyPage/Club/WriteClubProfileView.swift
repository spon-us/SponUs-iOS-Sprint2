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
    
    @ObservedObject var mypageVM: MypageViewModel
    
    
    @State var buttonDisabled: [WriteClubProfileTab : Bool] = [.image : true, .name : true, .introduce : true, .member : true, .link : true, .field : true]
    
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {
                    
                    ImageTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM, buttonDisabled: $buttonDisabled)
                        .tag(WriteClubProfileTab.image)
                    
                    NameTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM, buttonDisabled: $buttonDisabled)
                        .tag(WriteClubProfileTab.name)
                    
                    IntroduceTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM, buttonDisabled: $buttonDisabled)
                        .tag(WriteClubProfileTab.introduce)
                    
                    MemberTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM, buttonDisabled: $buttonDisabled)
                        .tag(WriteClubProfileTab.member)
                    
                    LinkTabView(selectedPage: $selectedPage, WriteClubProfileVM: mypageVM, buttonDisabled: $buttonDisabled)
                        .tag(WriteClubProfileTab.link)
                    
                    FieldTabView(mypageViewModel: mypageVM, buttonDisabled: $buttonDisabled)
                        .tag(WriteClubProfileTab.field)
                    
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
    
    @ObservedObject var mypageViewModel: MypageViewModel
    
    @Binding var buttonDisabled: [WriteClubProfileTab : Bool]
    
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
                print(mypageViewModel.clubImage)
                if let image = mypageViewModel.clubImage {
                    mypageViewModel.postProfileImage(UIImage: image)
                }
            }, label: {
                Text("이미지 업로드")
            })
            
            Button(action: {
                selectedPage = .name
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.image]!)
            })
            .disabled(buttonDisabled[.image]!)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("이미지탭 생성")
        }
        .onChange(of: selectedImage) {
            if selectedImage == nil {
                buttonDisabled[.image] = true
                print(buttonDisabled[.image]!)
                mypageViewModel.clubImage = selectedImage
            }
            else {
                buttonDisabled[.image] = false
                print(buttonDisabled[.image]!)
                mypageViewModel.clubImage = selectedImage
            }
        }
    }
}




struct NameTabView: View {
    
    @State var text = ""
    var limitTextCount = 13
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var mypageViewModel: MypageViewModel
    
    @Binding var buttonDisabled: [WriteClubProfileTab : Bool]
    
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
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.name]!)
            })
            .disabled(buttonDisabled[.name]!)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("네임탭 생성")
        }
        .onChange(of: text) {
            if text.count == 0 || text.count > limitTextCount {
                buttonDisabled[.name] = true
                print(buttonDisabled[.name]!)
                mypageViewModel.clubProfile?.name = text
            }
            else {
                buttonDisabled[.name] = false
                print(buttonDisabled[.name]!)
                mypageViewModel.clubProfile?.name = text
            }
        }
    }
}

struct IntroduceTabView: View {
    
    @State var text = ""
    var limitTextCount = 300
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var mypageViewModel: MypageViewModel
    
    @Binding var buttonDisabled: [WriteClubProfileTab : Bool]

    
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
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.introduce]!)
            })
            .disabled(buttonDisabled[.introduce]!)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("정보입력탭 생성")
        }
        .onChange(of: text) {
            if text.count == 0 || text.count > limitTextCount {
                buttonDisabled[.introduce] = true
                mypageViewModel.clubProfile?.description = text
            }
            else {
                buttonDisabled[.introduce] = false
                mypageViewModel.clubProfile?.description = text
            }
        }
    }
}

struct MemberTabView: View {
    
    @State private var text = ""
    var limitTextCount = 999
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var mypageViewModel: MypageViewModel
    
    @Binding var buttonDisabled: [WriteClubProfileTab : Bool]

    
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
                    
                    TextField("ex. 999", text: $text)
                        .keyboardType(.numberPad)
                        .onReceive(Just(text)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                text = filtered
                            }
                        }
                        .textFieldStyle(SponusTextfieldStyle(text: $text, limitTextCount: limitTextCount))
                        .padding(.bottom, 8)
       
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                selectedPage = .link
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: buttonDisabled[.member]!)
            })
            .disabled(buttonDisabled[.member]!)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("회원수 입력탭 생성")
        }
        .onChange(of: text) {
            if let numberValue = Int(text), numberValue > 0 {
                buttonDisabled[.member] = false
                mypageViewModel.clubProfile?.memberCount = Int(text) ?? 0
            }
            else {
                buttonDisabled[.member] = true
                mypageViewModel.clubProfile?.memberCount = Int(text) ?? 0
            }
        }
    }
}

struct LinkTabView: View {
    
    @State private var instagramUrl = ""
    @State private var facebookUrl = ""
    @State private var WebsiteUrl = ""
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var WriteClubProfileVM: MypageViewModel
    
    @Binding var buttonDisabled: [WriteClubProfileTab : Bool]

    
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
    
    var limitTextCount = 999
    
    let maxSelections = 2
    
    @ObservedObject var mypageViewModel: MypageViewModel
    
//    @State private var categories: [ClubCategorySelection] = ClubCategory.allCases.dropFirst().map {
//        ClubCategorySelection(category: $0, isSelected: false)
//    }
    
    var categories2 = ClubCategory.allCases.dropFirst().map { $0.rawValue }
    @State var selectedCategories: [String] = []
    
    @Binding var buttonDisabled: [WriteClubProfileTab : Bool]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Button(action: {
                        print(mypageViewModel.clubProfile)
                    }, label: {
                        Text("클럽프로필 출력")
                    })
                    
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
                    
                    ForEach(categories2, id: \.self) { category in
                        SelectinOptionCell(text: category, isSelected: selectedCategories.contains(category))
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
                                // 매핑
//                                print(getMappedStrings(from: selectedCategories))
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: buttonDisabled[.image]! || buttonDisabled[.name]! || buttonDisabled[.introduce]! || buttonDisabled[.member]! || buttonDisabled[.field]!)
            })
            .disabled(buttonDisabled[.image]! || buttonDisabled[.name]! || buttonDisabled[.introduce]! || buttonDisabled[.member]! || buttonDisabled[.field]!)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("동아리 분야 입력탭 생성")
        }
        .onChange(of: selectedCategories) {
            if selectedCategories.count > 0 && selectedCategories.count <= 2 {
                buttonDisabled[.field] = false
                mypageViewModel.clubProfile?.clubTypes = getMappedStrings(from: selectedCategories)
            }
            else {
                buttonDisabled[.field] = true
                mypageViewModel.clubProfile?.clubTypes = getMappedStrings(from: selectedCategories)
            }
        }
    }
    
    private func getMappedStrings(from categories: [String]) -> [String] {
        let mapping: [String: String] = [
            ClubCategory.planningAndIdeas.rawValue: "PLANNING_IDEA",
            ClubCategory.advertisingAndMarketing.rawValue: "AD_MARKETING",
            ClubCategory.design.rawValue: "DESIGN",
            ClubCategory.photographyAndVideo.rawValue: "PHOTO_VIDEO",
            ClubCategory.iTAndSoftware.rawValue: "IT_SOFTWARE",
            ClubCategory.others.rawValue: "ETC"
        ]
        
        return categories.compactMap { mapping[$0] }
    }
}


