//
//  MypageViewHelper.swift
//  Spon-Us
//
//  Created by 황인성 on 6/26/24.
//

import SwiftUI
import PhotosUI

struct SponusButtonLabel: View {
    
    var text: String
    var disabledCondition: Bool
    
    var body: some View {
        Text(text)
            .font(.But1KrBd)
            .foregroundStyle(disabledCondition ? Color.textDisabled : Color.textWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: disabledCondition ? 0.5 : 0)
                    .fill(disabledCondition ? Color.line100 : Color.textBrand)
                    .stroke(disabledCondition ? Color.line200 : Color.clear, lineWidth: 1)
                
                
            )
    }
}

struct WriteCancleModal: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navPathFinder: MypageNavigationPathFinder
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Group {
                Rectangle()
                    .frame(height: 0)
                
                Image(._117Caution)
                    .padding(.bottom, 16)
                    .padding(.top, 32)
                
                Text("프로필 작성을 중단할까요?")
                    .korFont(.H3KrBd)
                    .foregroundStyle(Color.textPrimary)
                    .padding(.bottom, 8)
                
                
                Text("마지막으로 작성하신 프로필까지 저장 되었어요.")
                    .korFont(.T4KrMd)
                    .foregroundStyle(Color.textSecondary)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 12)
            
            Button {
                dismiss()
                navPathFinder.path.popLast()
            } label: {
                Text("중단하기")
                    .korFont(.But1KrBd)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.textWhite)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.textBrand)
                    )
            }
            
            
            
            Button {
                dismiss()
            } label: {
                Text("돌아가기")
                    .korFont(.But1KrMd)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.textSecondary)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.bgWhite)
                    )
            }
        }
        .padding(.horizontal, 20)
    }
}

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


