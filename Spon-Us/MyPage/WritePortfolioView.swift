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
enum WritePortfolioTab: String, CaseIterable, Identifiable, TabItem {
    case projectName = "프로젝트명"
    case activityDetail = "활동 내용"
    case date = "날짜"
    case multiImage = "이미지"
    
    var id: String { self.rawValue }
}

// Generic WriteProfileTopTabBar
struct SponusTopTabBar<T: TabItem>: View {
    
    @Binding var selectedPage: T
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                
                ForEach(Array(T.allCases), id: \.self) { category in
                    
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

// WritePortfolioView using generic WriteProfileTopTabBar
struct WritePortfolioView: View {
    
    @State private var selectedPage: WritePortfolioTab = .multiImage
    
    var body: some View {
        
        ZStack {
            
            Color.bgSecondary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                SponusTopTabBar(selectedPage: $selectedPage)
                    .background(Color.bgSecondary)
                
                TabView(selection: $selectedPage) {
                    
                    ProjectNameTabView(selectedPage: $selectedPage)
                        .tag(WritePortfolioTab.projectName)
                    
                    ActivityDetailTabView(selectedPage: $selectedPage)
                        .tag(WritePortfolioTab.activityDetail)
                    
                    DateTabView(selectedPage: $selectedPage)
                        .tag(WritePortfolioTab.date)
                    
                    MultiImageTabView(selectedPage: $selectedPage)
                        .tag(WritePortfolioTab.multiImage)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
        }
        
    }
}

struct ProjectNameTabView: View {
    
    @State var text = ""
    var limitTextCount = 18
    
    @Binding var selectedPage: WritePortfolioTab
    
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
    
    @Binding var selectedPage: WritePortfolioTab
    
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
    
    @Binding var selectedPage: WritePortfolioTab
    
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
    
    @Binding var selectedPage: WritePortfolioTab
    
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

struct MultipleImagePicker: View {
//    @State private var selectedImages: [UIImage] = []
    @Binding var selectedImages: [UIImage]
    @State private var isImagePickerPresented = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(selectedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 106, height: 106)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Button(action: {
                    isImagePickerPresented.toggle()
                }, label: {
                    Image("icCancel")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36)
                        .rotationEffect(.degrees(45))
                        .padding(.all, 35)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .fill(Color.bgWhite)
                                .stroke(Color.line200, lineWidth: 1)

                        )
                    
                }).sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(selectedImages: $selectedImages, selectedImageCount: .multi)
                }
                
            }
            .padding(.horizontal, 20)
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    enum SelectedImageCount {
        case single
        case multi
    }
    
    
    @Binding var selectedImages: [UIImage]
    var selectedImageCount: SelectedImageCount
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = selectedImageCount == .single ? 1 : 0 // Set to 0 for multiple selections
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages.removeAll()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        } else if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}

struct SingleImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1 // Limit selection to 1 image
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: SingleImagePickerView
        
        init(_ parent: SingleImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        } else if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImage = image
                            }
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}



#Preview {
    WritePortfolioView()
}

