//
//  ContentView.swift
//  SU_HW1
//
//  Created by Yunjae Kim on 2020/08/19.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack{
            
                HomeMapView()
                    .frame(width : 475)
                    .edgesIgnoringSafeArea(.all)
                HappyImageView()
                    .offset(x: -300)
                    .padding(.trailing, 0)
                
                
                
            }
            
            VStack {
                Text("Happy's House")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                Text("Seochojungangro 24gil 43")
                    .font(.subheadline)
                
            }
            .padding()
            Spacer()
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
