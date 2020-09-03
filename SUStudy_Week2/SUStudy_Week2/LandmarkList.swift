//
//  LandmarkList.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/08/27.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView{
            List(landmarkData) { landmark in
                NavigationLink(destination : ContentView(landmark: landmark)){
                    LandmarkRow(landmark: landmark)
                }
        
                
                
            }
            .navigationBarTitle(Text("Landmarks"))
            
           
            
        }
        .onAppear(){
            UITableView.appearance().separatorStyle  = .none
        }
    
        
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 11 Pro"], id : \.self){ deviceName in
            
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
            
        }
        
    }
}
