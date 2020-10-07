//
//  RotateBadgeSymbol.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/09/10.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//

import SwiftUI

struct RotateBadgeSymbol: View {
    let angle :Angle
    var body: some View {
        BadgeSymbol()
        .padding(-60)
            .rotationEffect(angle,anchor: .bottom)
        
    }
}

struct RotateBadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        RotateBadgeSymbol(angle: .init(degrees: 5))
    }
}
