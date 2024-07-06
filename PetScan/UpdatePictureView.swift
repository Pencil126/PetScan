// UpdatePictureView.swift
// PetScan

import SwiftUI
import PhotosUI
import Vision
import CoreML

struct UpdatePictureView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var isPhotoPickerPresented = false
    @State private var isShowPhotoAlert = false
    @StateObject private var viewModel = PetScanDogAugmentationViewModel()
    
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var classificationLabel = "Tap 'Choose Picture' to select an image."
    
    var model: VNCoreMLModel? = {
        do {
            // 请确保这里的模型名称与您的文件名一致
            let config = MLModelConfiguration()
            return try VNCoreMLModel(for: PetScanDogAugmentation(configuration: config).model)
        } catch {
            print("Failed to load the model: \(error)")
            return nil
        }
    }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                    .frame(height: 710)
                VStack {
                    Spacer()
                    if let selectedImage = selectedImage {
                        Button{
                            isPhotoPickerPresented = true
                        }label: {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 362, height: 362)
                                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                        }
                    } else {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 350)
                                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                            Image("App")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .opacity(0.2)
                            VStack {
                                Button{
                                    isCameraPickerPresented = true
                                }label:{
                                    Text("開啟相機")
                                        .foregroundStyle(.white)
                                        .frame(width: 200, height: 45)
                                        .font(.system(size: 24))
                                        .background(selectedColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                }
                                .padding()
                                
                                Button{
                                    isPhotoPickerPresented = true
                                }label: {
                                    Text("上傳圖片")
                                        .foregroundStyle(.white)
                                        .frame(width: 200, height: 45)
                                        .font(.system(size: 24))
                                        .background(selectedColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                }
                                .padding()
                            }
                        }
                    }
                    
                    if selectedImage != nil{
                        NavigationLink {
                            AskSimpleQuestionsView(selectedImage: selectedImage)
                        } label: {
                            Text("基礎問題檢測")
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 65)
                                .font(.system(size: 24))
                                .background(selectedColor)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
//                        .onAppear{
//                            viewModel.predict(image: selectedImage! as! CGImage)
//                            detector.classifyImage(selectedImage!)
//                        }
                    }
                    else{
                        Button{
                            self.isShowPhotoAlert = true
                        }label: {
                            Text("基礎問題檢測")
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 65)
                                .font(.system(size: 24))
                                .background(selectedColor)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        .alert("請拍攝或上傳圖片", isPresented: $isShowPhotoAlert) {
                            Button("好"){
                                isShowPhotoAlert = false
                            }
                        }
                    }
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("皮膚病檢測")
                            .font(.system(size: 24))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .fullScreenCover(isPresented: $isCameraPickerPresented) {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
            }
            .fullScreenCover(isPresented: $isPhotoPickerPresented) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}



#Preview {
    TabBarView(tabViewSelection: 0)
}
