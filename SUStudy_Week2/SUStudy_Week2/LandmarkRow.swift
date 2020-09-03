//
//  LandmarkRow.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/08/27.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark : Landmark
    
    var body: some View {
        HStack{
            landmark.image.resizable().frame(width : 50, height: 50)
            VStack(alignment: .leading) {
                Text(landmark.name)
                Text(landmark.state)
            }
    
            Spacer()
            
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LandmarkRow(landmark : landmarkData[0]).previewLayout(.fixed(width: 300, height: 70))
            LandmarkRow(landmark : landmarkData[1]).previewLayout(.fixed(width: 300, height: 70))
            
            
        }
        
    }
}
