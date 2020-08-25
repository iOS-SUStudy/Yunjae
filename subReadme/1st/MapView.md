# MapView

- MapView를 사용하기 위해서 UIViewRepresentable을 상속받아야 함.
- 필수적으로 구현해야하는 함수 (makeUIView, updateUIView가 있음)
- 코드 예시 ( coordinate : 좌표 , span : 확대)

```swift

import SwiftUI
import MapKit


struct HomeMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame : .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 37.496250, longitude: 127.018885)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
    }
}

struct HomeMapView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMapView()
    }
}

```
