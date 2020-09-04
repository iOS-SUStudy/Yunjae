# EnvironmentObject

- EnvironmentObject 형으로 선언된 변수를 이용해 편하게 구현할 수 있음.
- 밑의 예시는 별표 처리된 셀만 보여줄 것인지의 정보와 표시할 데이터를 담은 UserData를 구현.

```swift

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var userData : UserData
    
    
    var body: some View {
        NavigationView{
            
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
            
            
            
        }
        .onAppear(){
            UITableView.appearance().separatorStyle  = .none
        }
        
        
        
    }
}

```


UserData.swift
```swift


import SwiftUI
import Combine

final class UserData: ObservableObject  {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    @Published var showFeaturedOnly = false
}



```
