//
//  ContentView.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/08/27.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var landmark : Landmark
    var body: some View {
        VStack {
            
            MapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height : 300)
            
            CircleImage(image: landmark.image)
                .offset(y : -130)
                .padding(.bottom, -130)

            
            VStack(alignment : .leading) {
                
                Text(landmark.name)
                    .font(.title)
                    .foregroundColor(.black)
                HStack(alignment: .top) {
                    Text(landmark.park)
                        .font(.subheadline)
                    Spacer()
                    
                    Text(landmark.state)
                        .font(.subheadline)
                   

                    
                }
                
            }
            .padding()
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(landmark: landmarkData[0])
    }
}
