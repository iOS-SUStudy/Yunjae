# NavigationView

- navigationBarTitle 속성을 통해 Bar title의 이름 지정
- 밑의 예시는 별표 처리된(isFavorite 변수) 가 true인 cell만 보여주는 토글을 추가함
- UITableView.appearance().seperatorStyle = .none을 이용해 구분선을 없앨 수 있다.

```swift

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

```
