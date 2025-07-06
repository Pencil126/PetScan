import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let johnson = CLLocationCoordinate2D(latitude: 24.162799, longitude: 120.656954)
    static let diaJia = CLLocationCoordinate2D(latitude: 24.161136, longitude: 120.655195)
}

struct HospitalMapView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    @State var searchBarText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                VStack {
                    SearchBar(text: $searchBarText)
                    MapView()
                        .frame(width: 350, height: 323)
                        .cornerRadius(10)
                    
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 95)
                            VStack(alignment: .leading){
                                Text("大佳動物醫院")
                                    .font(.system(size: 24))
                                    .frame(width: 305,alignment: .leading)
                                Text("營業時間：14:00-18:00 19:00-21:00")
                                    .frame(width: 305,alignment: .leading)
                            }
                            .frame(width: 305)
                        }
                        .padding(4)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 95)
                            VStack(alignment: .leading){
                                Text("強生動物醫院")
                                    .font(.system(size: 24))
                                    .frame(width: 305,alignment: .leading)
                                Text("營業時間：休息")
                                    .frame(width: 305,alignment: .leading)
                            }
                            .frame(width: 305)
                        }
                        .padding(4)
                    }
                    .padding(4)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("獸醫院地圖")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MapView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(mapView)
        
        // Constraints for mapView
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
        ])
        
        // Set background color
        viewController.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        
        // Add markers
        let johnsonAnnotation = MKPointAnnotation()
        johnsonAnnotation.coordinate = .johnson
        johnsonAnnotation.title = "強生動物醫院"
        
        let diaJiaAnnotation = MKPointAnnotation()
        diaJiaAnnotation.coordinate = .diaJia
        diaJiaAnnotation.title = "大佳動物醫院"
        
        mapView.addAnnotations([johnsonAnnotation, diaJiaAnnotation])
        
        // Adjust map region to show all annotations
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            TextField("搜尋......", text: $text)
                .frame(width: 295)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button{
                                self.text = ""
                            }label:{
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                        else{
                            Image(systemName: "mic")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
}

#Preview {
    TabBarView(tabViewSelection: 0)
}
