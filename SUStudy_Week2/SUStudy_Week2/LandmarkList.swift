//
//  LandmarkList.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/08/27.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var userData : UserData
    
    
    var body: some View {
        
        
        List{
            Toggle(isOn : $userData.showFavoritesOnly){
                Text("Favorites Only")
            }
            
            
            ForEach(userData.landmarks) { landmark in
                if !self.userData.showFavoritesOnly ||
                    landmark.isFavorite{
                    NavigationLink(destination : ContentView(landmark: landmark)){
                        LandmarkRow(landmark: landmark)
                    }
                    
                    
                }
                
            }
            
            
            
            
        }
        .navigationBarTitle(Text("Landmarks"))
            
            
            
            
        .onAppear(){
            UITableView.appearance().separatorStyle  = .none
        }
        
        
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 11 Pro"], id : \.self){ deviceName in
            NavigationView{
                LandmarkList()
                    .environmentObject(UserData())
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
            
        }
        
    }
}
