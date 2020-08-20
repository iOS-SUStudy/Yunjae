//
//  HomeMapView.swift
//  SU_HW1
//
//  Created by Yunjae Kim on 2020/08/19.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

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
