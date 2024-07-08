//
//  DiseaseOutcomeView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct DiseaseOutcomeView: View {
    var selectedImage: UIImage?
    @StateObject private var viewModel = PetScanDogAugmentationViewModel()
    
    @State var isOn1: Bool?
    @State var isOn2: Bool?
    @State var isOn3: Bool?
    @State var isOn4: Bool?
    @State var isOn5: Bool?
    @State var isOn6: Bool?
    @State var isOn7: Bool?
    @State var isOn8: Bool?
    @State var petActionStatus: Int = 0
    
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                VStack{
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 263)
                        .padding()
                        .onAppear{
                            let cgImage = convertUItoCGImage(uiimage: selectedImage!)
                            viewModel.predict(image: cgImage)
                            if isOn1 == true {
                                petActionStatus += 1
                            }
                            if isOn2 == true {
                                petActionStatus += 1
                            }
                            if isOn3 == true {
                                petActionStatus += 1
                            }
                            if isOn4 == true {
                                petActionStatus += 1
                            }
                            if isOn5 == true {
                                petActionStatus += 1
                            }
                        }
                    if viewModel.predictionResult == "AD" {
                        Text("異位性皮膚炎\n(Canine Atopic Dermatitis，CAD)")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding()
                        if petActionStatus >= 2 {
                            Text("請儘速就醫")
                                .font(.system(size: 48))
                                .foregroundStyle(.white)
                        } else if petActionStatus < 2 {
                            Text("請維持環境清潔，並持續觀察情況")
                                .dynamicTypeSize(.xxLarge)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                        }
                        NavigationLink {
                            HospitalMapView()
                        } label: {
                            Text("獸醫院地圖")
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 65)
                                .font(.system(size: 24))
                                .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    } else if viewModel.predictionResult == "AMD" {
                        Text("濕疹\n(Acute Moist Dermatitis，AMD)")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding()
                        if isOn6 == true {
                            Text("請維持環境乾燥")
                                .dynamicTypeSize(.xxLarge)
                                .foregroundStyle(.white)
                        }
                        if isOn7 == true && isOn8 == true {
                            Text("請小心跳蚤")
                                .dynamicTypeSize(.xxLarge)
                                .foregroundStyle(.white)
                        }
                        if isOn6 == false && (isOn7 == false || isOn8 == false) {
                            Text("請改用溫和、自然的沐浴乳且沖洗確實，並落實吹乾毛髮")
                                .dynamicTypeSize(.xxLarge)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                        }
                        NavigationLink {
                            HospitalMapView()
                        } label: {
                            Text("獸醫院地圖")
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 65)
                                .font(.system(size: 24))
                                .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    } else {
                        Text("健康")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("皮膚病檢測結果")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func convertCItoCGImage(ciImage: CIImage) -> CGImage {
        let ciContext = CIContext.init()
        let cgImage: CGImage = ciContext.createCGImage(ciImage, from: ciImage.extent)!
        return cgImage
    }
    func convertUItoCGImage(uiimage: UIImage) -> CGImage {
        var cgImage = uiimage.cgImage
        
        if cgImage == nil {
            let ciImage = uiimage.ciImage
            cgImage = self.convertCItoCGImage(ciImage: ciImage!)
        }
        return cgImage!
    }
}

#Preview {
    TabBarView(tabViewSelection: 0)
}
