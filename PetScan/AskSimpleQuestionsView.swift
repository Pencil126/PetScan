import SwiftUI

struct CustomToggle: ToggleStyle {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 0) {
            ZStack{
                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 10))
                    .frame(width: 40, height: 37)
                    .foregroundStyle(configuration.isOn ? Color.white : selectedColor)
                Text("無")
                    .font(.system(size: 20))
                    .foregroundStyle(configuration.isOn ? themeColor : .white)
            }
            .onTapGesture {
                configuration.isOn = false
            }
            
            
            ZStack{
                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(bottomTrailing: 10, topTrailing: 10))
                    .frame(width: 40, height: 37)
                    .foregroundStyle(configuration.isOn ? selectedColor : Color.white)
                Text("有")
                    .font(.system(size: 20))
                    .foregroundStyle(configuration.isOn ? .white : themeColor)
            }
            .onTapGesture {
                configuration.isOn = true
            }
            
            
        }
        .padding(2)
    }
}


struct AskSimpleQuestionsView: View {
    var selectedImage: UIImage?
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    
    @State private var isOn1: Bool = false
    @State private var isOn2: Bool = false
    @State private var isOn3: Bool = false
    @State private var isOn4: Bool = false
    @State private var isOn5: Bool = false
    @State private var isOn6: Bool = false
    @State private var isOn7: Bool = false
    @State private var isOn8: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                    .frame(height: 710)
                VStack {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 37)
                                .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            Text("自家寵物是否有以下狀況發生")
                                .font(.system(size: 20))
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        
                        Divider()
                            .overlay(Color.white)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                        Group {
                            QuestionRow(question: "皮膚發紅和腫脹", isOn: $isOn1)
                            QuestionRow(question: "搔癢、舔舐或咬嚙毛皮", isOn: $isOn2)
                            QuestionRow(question: "結痂、鱗屑或片狀皮膚", isOn: $isOn3)
                            QuestionRow(question: "皮膚腫脹或腫塊", isOn: $isOn4)
                            QuestionRow(question: "毛皮脫落", isOn: $isOn5)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 37)
                                .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            Text("環境評估")
                                .font(.system(size: 20))
                        }
                        
                        Divider()
                            .overlay(Color.white)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                        Group {
                            QuestionRow(question: "環境是否太潮濕", isOn: $isOn6)
                            QuestionRow(question: "是否常外出散步", isOn: $isOn7)
                            QuestionRow(question: "是否有接觸草叢", isOn: $isOn8)
                        }
                    }
                    NavigationLink {
                        DiseaseOutcomeView(selectedImage: selectedImage)
                    } label: {
                        Text("查看檢測結果")
                            .foregroundStyle(.white)
                            .frame(width: 350,height: 65)
                            .font(.system(size: 24))
                            .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                            .clipShape(RoundedRectangle(cornerRadius: 30))

                    }
                    
                }
            }
        }
        .toolbar(){
            ToolbarItem(placement: .principal) {
                Text("基礎問題檢測")
                    .font(.system(size: 24))
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuestionRow: View {
    var question: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(question)
                .font(.system(size: 20))
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(CustomToggle())
        }
        .frame(width: 350)
    }
}

#Preview{
    TabBarView(tabViewSelection: 0)
}
