//
//  WritePortfolioView.swift
//  Spon-Us
//
//  Created by 황인성 on 6/24/24.
//

import SwiftUI
import PhotosUI

// Protocol for TabItem
protocol TabItem: CaseIterable, Hashable, Identifiable, RawRepresentable where RawValue == String {}

// Enum for WritePortfolioTab
enum WriteClubPortfolioTab: String, CaseIterable, Identifiable, TabItem {
    case projectName = "프로젝트명"
    case activityDetail = "활동 내용"
    case date = "날짜"
    case multiImage = "이미지"
    
    var id: String { self.rawValue }
}



// WritePortfolioView using generic WriteProfileTopTabBar
struct WriteClubPortfolioView: View {
    
    @State private var selectedPage: WriteClubPortfolioTab = .projectName
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                
                TabView(selection: $selectedPage) {
                    
                    ProjectNameTabView(selectedPage: $selectedPage)
                        .tag(WriteClubPortfolioTab.projectName)
                    
                    ActivityDetailTabView(selectedPage: $selectedPage)
                        .tag(WriteClubPortfolioTab.activityDetail)
                    
                    DateTabView(selectedPage: $selectedPage)
                        .tag(WriteClubPortfolioTab.date)
                    
                    MultiImageTabView(selectedPage: $selectedPage)
                        .tag(WriteClubPortfolioTab.multiImage)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {
                    CustomBackButton()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("버튼")
                    })
                }
            }
        }
        
    }
}

struct ProjectNameTabView: View {
    
    @State var text = ""
    var limitTextCount = 18
    
    @Binding var selectedPage: WriteClubPortfolioTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("활동한 프로젝트 명을\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    TextField("ex. 스포너스 카드뉴스 제작", text: $text)
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
                
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)

    }
}

struct ActivityDetailTabView: View {
    
    @State var text = ""
    var limitTextCount = 48
    
    @Binding var selectedPage: WriteClubPortfolioTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("프로젝트 활동 내용을\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    TextEditor(text: $text)
                        .modifier(SponusTextEditorModifier(text: $text, limitTextCount: limitTextCount, height: 112, placeHolder: "프로젝트의 구체적인 활동 내용                             "))
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
                
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)

    }
}

struct DateTabView: View {
    
    @State var text = ""
    var limitTextCount = 48
    
    @Binding var selectedPage: WriteClubPortfolioTab
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .frame(height: 0)
                        .padding(.top, 36)
                    
                    Text("활동한 프로젝트의 날짜를\n입력해 주세요")
                        .font(.H2KrBd)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 20)
                    
                    
                    TextField("ex. 2024.01.01 ~ 2024.02.01", text: $text)
                        .textFieldStyle(SponusTextfieldStyle(text: $text, limitTextCount: limitTextCount))
                        .padding(.bottom, 8)
                    
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })

                    
                }
                .padding(.horizontal, 20)
            }
        
            Button(action: {
                
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: text.count == 0 || text.count > limitTextCount)
            })
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)

    }
}

struct MultiImageTabView: View {
    
    @State var text = ""
    var limitTextCount = 48
    
    @Binding var selectedPage: WriteClubPortfolioTab
    
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Group {
                        
                        Rectangle()
                            .frame(height: 0)
                            .padding(.top, 36)
                        
                        Text("활동한 프로젝트의 이미지를\n첨부해 주세요")
                            .font(.H2KrBd)
                            .foregroundStyle(Color.textPrimary)
                            .padding(.bottom, 4)
                        
                        Text("1개 첨부 필수")
                            .font(.B2KrMd)
                            .foregroundColor(Color.textDisabled)
                            .padding(.bottom, 20)
                            .padding(.leading, 2)
                    }
                    .padding(.horizontal, 20)
    
                    MultipleImagePicker(selectedImages: $selectedImages)
                    
                }
                
            }
        
            Button(action: {
                
            }, label: {
                SponusButtonLabel(text: "완료", disabledCondition: selectedImages.isEmpty)
            })
            .padding(.horizontal, 20)
            
        }
        .background(Color.bgSecondary)

    }
}




#Preview {
    WriteClubPortfolioView()
}

