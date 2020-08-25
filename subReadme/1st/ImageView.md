# ImageView

- clipshape : 이미지의 모양
- frame : 크기 지정
- shadow : 그림자 지정
- overlay : 이미지를 둘러싸는 테두리 지정

```swift

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


```
