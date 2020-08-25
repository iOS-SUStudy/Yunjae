# HStack, VStack

- HStack{} , VStack{} 으로 View들을 Stack에 묶어줄 수 있음.
- HStack : 가로 방향으로 묶임. VStack : 세로 방향으로 묶임.


- 코드 예시

```swift
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

```


