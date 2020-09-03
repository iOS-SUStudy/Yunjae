//
//  CircleImage.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/08/27.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    
    var image : Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image : landmarkData[0].image)
    }
}
