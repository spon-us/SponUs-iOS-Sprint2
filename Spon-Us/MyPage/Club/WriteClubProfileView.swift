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
    
//    @State var existProfile = false
    
    
    
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary
            
            VStack(spacing: 0) {
                
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {
                    
                    ImageTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM)
                        .tag(WriteClubProfileTab.image)
                    
                    NameTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM)
                        .tag(WriteClubProfileTab.name)
                    
                    IntroduceTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM)
                        .tag(WriteClubProfileTab.introduce)
                    
                    MemberTabView(selectedPage: $selectedPage, mypageViewModel: mypageVM)
                        .tag(WriteClubProfileTab.member)
                    
                    LinkTabView(selectedPage: $selectedPage, WriteClubProfileVM: mypageVM)
                        .tag(WriteClubProfileTab.link)
                    
                    FieldTabView(mypageViewModel: mypageVM)
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
    
//    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    @ObservedObject var mypageViewModel: MypageViewModel
    
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
                            
                            if let selectedImage = mypageViewModel.clubImage {
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
                        SingleImagePickerView(selectedImage: $mypageViewModel.clubImage)
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
                SponusButtonLabel(text: "다음", disabledCondition: mypageViewModel.clubImageTabDisabledCondition ?? true)
            })
            .disabled(mypageViewModel.clubImageTabDisabledCondition ?? true)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("이미지탭 생성")
            mypageViewModel.checkClubImageTabDisabledCondition()
        }
        .onChange(of: mypageViewModel.clubImage) {
            mypageViewModel.checkClubImageTabDisabledCondition()
        }
    }
}




struct NameTabView: View {
    
//    @State var text = ""
//    var limitTextCount = 13
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var mypageViewModel: MypageViewModel
    
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
                    
                    TextField("ex. 스포너스 기획 동아리", text: $mypageViewModel.clubName)
                        .textFieldStyle(SponusTextfieldStyle(text: $mypageViewModel.clubName, limitTextCount: mypageViewModel.clubNameLimitTextCount))
                        .padding(.bottom, 8)
                    
                    Text("(\(mypageViewModel.clubName.count)/\(mypageViewModel.clubNameLimitTextCount))")
                        .font(.B2EnMd)
                        .foregroundStyle(Color.textTertiary)
                        .padding(.leading, 12)
                    
                }
                .padding(.horizontal, 20)
            }

            Button(action: {
                selectedPage = .introduce
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: mypageViewModel.clubNameTabDisabledCondition ?? true)
            })
            .disabled(mypageViewModel.clubNameTabDisabledCondition ?? true)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("네임탭 생성")
            mypageViewModel.checkClubNameTabDisabledCondition()
        }
        .onChange(of: mypageViewModel.clubName) {
            mypageViewModel.checkClubNameTabDisabledCondition()
        }

    }
    
}

struct IntroduceTabView: View {
    
//    @State var text = ""
//    var limitTextCount = 300
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var mypageViewModel: MypageViewModel

    
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
                    
                    TextEditor(text: $mypageViewModel.clubDescription)
                        .modifier(SponusTextEditorModifier(text: $mypageViewModel.clubDescription, limitTextCount: mypageViewModel.clubDescriptionLimitTextCount, height: 260, placeHolder: "ex. 안녕하세요. 저희는 스포대학교의 마케팅 기획을 하는 동아리 ‘스포대학교' 기획동아리 입니다."))
                        .padding(.bottom, 8)
                    
                    HStack(spacing: 0) {
                        
                        Text("(\(mypageViewModel.clubDescription.count)/\(mypageViewModel.clubDescriptionLimitTextCount))")
                            .font(.B2EnMd)
                            .foregroundStyle(Color.textTertiary)
                        
                        Spacer()
                        
                        Button(action: {
                            mypageViewModel.clubDescription = ""
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
                SponusButtonLabel(text: "다음", disabledCondition: mypageViewModel.clubDescriptionTabDisabledCondition ?? true)
            })
            .disabled(mypageViewModel.clubDescriptionTabDisabledCondition ?? true)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("정보입력탭 생성")
            mypageViewModel.checkClubDescriptionTabDisabledCondition()
        }
        .onChange(of: mypageViewModel.clubDescription) {
            mypageViewModel.checkClubDescriptionTabDisabledCondition()
        }

    }
}

struct MemberTabView: View {
    
//    @State private var number = ""
    var limitTextCount = 999
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var mypageViewModel: MypageViewModel

    
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
                    
                    TextField("ex. 999", text: $mypageViewModel.clubMemberCount)
                        .keyboardType(.numberPad)
                        .onReceive(Just(mypageViewModel.clubMemberCount)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.mypageViewModel.clubMemberCount = filtered
                            }
                        }
                        .textFieldStyle(SponusTextfieldStyle(text: $mypageViewModel.clubMemberCount, limitTextCount: limitTextCount))
                        .padding(.bottom, 8)
       
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                selectedPage = .link
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: mypageViewModel.clubMemberTabDisabledCondition ?? true)
            })
            .disabled(mypageViewModel.clubMemberTabDisabledCondition ?? true)
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("회원수 입력탭 생성")
            mypageViewModel.checkClubMemberTabDisabledCondition()
        }
        .onChange(of: mypageViewModel.clubMemberCount) {
            mypageViewModel.checkClubMemberTabDisabledCondition()
        }
    }
    
//    private func isButtonDisabled() -> Bool {
//        guard let numberValue = Int(WriteClubProfileVM.clubMemberCount), numberValue > 0 else {
//            return true
//        }
//        return false
//    }
}

struct LinkTabView: View {
    
    @State private var instagramUrl = ""
    @State private var facebookUrl = ""
    @State private var WebsiteUrl = ""
    
    @Binding var selectedPage: WriteClubProfileTab
    @ObservedObject var WriteClubProfileVM: MypageViewModel

    
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
//    @State private var number = ""
    var limitTextCount = 999
    
    let maxSelections = 2
    @ObservedObject var mypageViewModel: MypageViewModel
    
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
                                let selectedCategories = categories.filter { $0.isSelected }.map { $0.category.rawValue }
                                mypageViewModel.clubTypes = getMappedStrings(from: selectedCategories)
                                print(categories)
                                print(mypageViewModel.clubTypes)
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                let selectedCategories = categories.filter { $0.isSelected }.map { $0.category.rawValue }
                print(getMappedStrings(from: selectedCategories))
                print(selectedCategories)
                
//                mypageViewModel.patchClubProfile(clubProfile: ClubProfile)
                
            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: mypageViewModel.patchClubProfileDisabledCondition)
            })
            .disabled(mypageViewModel.patchClubProfileDisabledCondition)
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
        .onAppear {
            print("동아리 분야 입력탭 생성")
            mypageViewModel.checkClubTypesTabDisabledCondition()
            mypageViewModel.checkPatchClubProfileDisabledCondition()
        }
        .onChange(of: mypageViewModel.clubTypes) {
            mypageViewModel.checkClubTypesTabDisabledCondition()
            mypageViewModel.checkPatchClubProfileDisabledCondition()
        }
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


