//
//  WriteClubPortfolioView.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
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
    @State private var startDate = ""
    @State private var endDate = ""
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
                    
                    TextField("ex. 2024.01.01 ~ 2024.02.01", text: $startDate)
                        .textFieldStyle(SponusTextfieldStyle(text: $startDate, limitTextCount: limitTextCount))
                        .padding(.bottom, 8)
                        .onChange(of: startDate) { newValue in
                            startDate = formatDateInput(newValue)
                        }
                    
                    DatePicker(selection: .constant(Date()), label: { Text("Date") })
                }
                .padding(.horizontal, 20)
            }
        
            Button(action: {
                // 다음 버튼 액션
            }, label: {
                SponusButtonLabel(text: "다음", disabledCondition: startDate.isEmpty || endDate.isEmpty)
            })
            .padding(.horizontal, 20)
        }
        .background(Color.bgSecondary)
    }

    // 날짜 입력을 포맷팅하는 함수
    private func formatDateInput(_ input: String) -> String {
        // 숫자와 마침표만 남기고 나머지 문자는 제거합니다.
        let filtered = input.filter { "0123456789.~".contains($0) }
        
        // 각 날짜 부분을 분리하여 배열에 저장합니다.
        var parts = filtered.components(separatedBy: "~").map { $0.trimmingCharacters(in: .whitespaces) }
        
        if parts.count > 2 {
            // "~" 기호가 두 번 이상 들어간 경우 첫 두 개만 사용하고 나머지는 무시합니다.
            parts = Array(parts.prefix(2))
        }
        
        // 날짜 형식을 유지하기 위해 각 부분을 다시 결합합니다.
        let formatted = parts.joined(separator: " ~ ")
        
        return formatted
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
