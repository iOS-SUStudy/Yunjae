//
//  HappyImageView.swift
//  SU_HW1
//
//  Created by Yunjae Kim on 2020/08/19.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct HappyImageView: View {
    var body: some View {
        Image("picture9").resizable()
            .clipShape(Capsule())
            .frame(width : 50, height :80)
            .shadow(radius: 30)
            .overlay(
            Capsule().stroke(Color.white, lineWidth: 4))
        
    }
}

struct HappyImageView_Previews: PreviewProvider {
    static var previews: some View {
        HappyImageView()
    }
}
