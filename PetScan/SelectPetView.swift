import SwiftUI


struct SelectPetView: View {
    @State var userPets: Pets
    let columns = [
        GridItem(.flexible(), spacing: -50), // 調整這裡的spacing以減少橫向間距
        GridItem(.flexible(), spacing: -50)  // 調整這裡的spacing以減少橫向間距
    ]
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                ZStack{
                    HStack {
                        Spacer()
                        Text("選擇哪隻寵物？")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .padding(.top)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text("編輯")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .bold()
                            .padding(.trailing)
                            .padding(.top)
                    }
                }
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 20) { // 調整這裡的spacing以減少縱向間距
                    ForEach(userPets.petList) { pet in
                        SelectPetImageView(pet: pet)
                    }
                    AddPetView() // 在網格中添加“新增寵物”按鈕
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct SelectPetImageView: View {
    var pet: Pet
    
    var body: some View {
        VStack {
            Image(pet.petAvatar)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100) // 調整圖片大小以減少占用空間
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 5)
            Text(pet.petName)
                .foregroundColor(.white)
                .font(.system(size: 18))
                .padding(.top, 2) // 調整這裡的padding以減少文字與圖片之間的間距
        }
    }
}

struct AddPetView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(style: StrokeStyle(lineWidth: 2.5))
                .frame(width: 100, height: 100)
                .foregroundColor(.white.opacity(0.5))
                .overlay(
                    Text("+")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.8))
                )
            Text("新增寵物")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .padding(.top, 2)
        }
        .onTapGesture {
            // 在這裡添加您的新增寵物邏輯
            print("新增寵物")
        }
    }
}

// 預覽
struct SelectPetView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPetView(userPets: Pets(petList: [
            Pet(petName: "小瓜", petAvatar: "defaultAvatar"),
            Pet(petName: "毛毛", petAvatar: "defaultAvatar"),
            Pet(petName: "球球", petAvatar: "defaultAvatar")
        ]))
    }
}
