# 1/2 스터디 : anagram 게임 만들기


<img width="399" alt="스크린샷 2021-01-01 오전 11 57 50" src="https://user-images.githubusercontent.com/54928732/103432757-96f56700-4c28-11eb-83f9-793553c5b7ba.png">

### 오늘 만들어볼 앱은??

- 랜덤 String을 주고 해당하는 String으로 anagram을 만들어보는 앱입니다
- 주요한 기능으로는 입력된 단어가 올바른 단어인지를 확인하는 기능이 있어요



## GameViewModel

- 첫 선언부분

```swift
import Foundation
import Combine
import UIKit


final class GameViewModel: ObservableObject {
    @Published var allRootWords: [String] = []
    @Published var currentRootWord: String = ""
    @Published var currentGuess: String = ""
    @Published var usedWords: [String] = []
    @Published var currentScore = 0

    @Published var shouldShowErrorAlert: Bool = false
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    
    private static let textChecker = UITextChecker()
}


```

먼저 GameViewModel에서 사용될 변수들을 선언해주는 부분이에요. 



- initialize 부분.

```swift
// MARK: -  Init
extension GameViewModel {
    convenience init(rootWords: [String]) {
        self.init()
        self.allRootWords = rootWords
        
        startNewRound()
    }
}


```


- 변수 선언 부분
```swift
// MARK: - Computeds
extension GameViewModel {
    var currentGuessIsOriginal: Bool { !usedWords.contains(currentGuess) }
    
    var currentGuessIsAnagram: Bool {
        let guessSet = NSCountedSet(array: Array(currentGuess))
        let rootWordSet = NSCountedSet(array: Array(currentRootWord))
        
        return guessSet.allSatisfy { character in
            guessSet.count(for: character) <= rootWordSet.count(for: character)
        }
    }
    
    
    var currentGuessIsRealWord: Bool {
        let wordRange = NSRange(location: 0, length: currentGuess.utf16.count)
        
        let misspelledRange = Self.textChecker.rangeOfMisspelledWord(
            in: currentGuess,
            range: wordRange,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
}

```
    - currentGuessIsOriginal 에서 현재의 guess가 이전에 있었는지 확인,
    - currentGuessIsAnagram 에서 주어진 string의 char들을 모두 활용해서 만들어진 anagram인지를 확인,
    - currentGuessIsRealWord 에서 유저가 대답한 답이 올바른 단어인지를 확인해요.
      여기서 UITextChecker가 사용되는데요,, 단어인지 아닌지를 확인하고, 사용자가 단어를 추가해줄수도 있는 좋은 클래스입니다.
      [UITextChecker](https://developer.apple.com/documentation/uikit/uitextchecker)
      
      
      
- 함수 선언 

```swift
// MARK: - Public Methods
extension GameViewModel {
    
    func startNewRound() {
        usedWords.removeAll(keepingCapacity: true)
        currentGuess = ""
        currentScore = 0
        
        currentRootWord = allRootWords.randomElement()!
    }
    
    
    func checkNewWord() {
        let word = currentGuess.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
        guard !word.isEmpty else { return } // Ignore the input
 
        guard word.count > 1 else {
            setWordError(
                title: "Ha!",
                message: "We like letters, too. But you'll have to use more than one for a valid word."
            )
            return
        }
        
        guard word != currentRootWord else {
            setWordError(
                title: "Mix it up!",
                message: "Your answer shouldn't match the original word."
            )
            return
        }
        

        
        guard currentGuessIsOriginal else {
            setWordError(
                title: "Be original!",
                message: "You've already used \"\(word)\" as an anagram for \"\(currentRootWord)\"."
            )
            return
        }
        
        guard currentGuessIsAnagram else {
            setWordError(
                title: "Try Again",
                message: "\"\(word)\" is not an anagram for \"\(currentRootWord)\"."
            )
            return
        }
        
        guard currentGuessIsRealWord else {
            setWordError(
                title: "Is that a word?",
                message: "Unfortunatley, we don't recognize \"\(word)\" as a valid English word 🤷‍♂️."
            )
            return
        }
        
        currentScore += word.count
        usedWords.insert(word, at: 0)
        currentGuess = ""
    }
}
```
이 부분에서는 아까 설정해준 변수들을 활용해서 올바른 anagram인지 확인해주는 부분입니다



```swift
extension GameViewModel {
    
    func setWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        shouldShowErrorAlert = true
    }
}



#if DEBUG
let sampleWords = [
    "coffee",
    "cambridge",
    "digital",
    "agency",
    "wordsmith",
    "fahrenheit",
    "network",
]
#endif


```

여기서는 error를 사용자 메시지에 맞게 출력해주는 부분.

여기까지 GameViewModel 선언이 끝났습니다 ㅎㅎ


## GameView

- GameView 뷰 구성 부분

```swift
import SwiftUI


struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
}


// MARK: - Body
extension GameView {

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Choose an anagram for")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(viewModel.currentRootWord)")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(.pink)
                }
                .padding()
                
                
                TextField(
                    "Enter your word",
                    text: $viewModel.currentGuess,
                    onCommit: viewModel.checkNewWord
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()

                
                Form {
                    Section(
                        header: HStack {
                            Text("Used Words")
                            Spacer()
                            Text("Current Score: \(viewModel.currentScore)")
                        }
                        .font(.headline)
                        .padding()
                    ) {
                        List(viewModel.usedWords, id: \.self) { word in
                            Text(word)
                            Spacer()
                            Image(systemName: "\(word.count).circle")
                                .imageScale(.large)
                        }
                    }
                }
            }
            .navigationBarTitle("Anagrams")
            .navigationBarItems(leading: restartButton)
            .alert(isPresented: $viewModel.shouldShowErrorAlert) {
                Alert(
                    title: Text(self.viewModel.errorTitle),
                    message: Text(self.viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}



```


```swift
extension GameView {
    
    var restartButton: some View {
        Button(action: viewModel.startNewRound) {
            Image(systemName: "arrow.clockwise")
            Text("Restart")
        }
    }
}


// MARK: - Preview
struct GameView_Previews: PreviewProvider {

    static var previews: some View {
        GameView(viewModel: GameViewModel(rootWords: sampleWords))
    }
}


```

위에서는 Restart Button을 구현하고 Preview를 구현해요
여기까지 구현했으면 거의 완성!
이제 여기까지 만들어준 뷰를 GameContainerView애 넣어주면 됩니다.


## GameContainerView

```swift
import SwiftUI


struct GameContainerView: View {
    @ObservedObject var gameViewModel = GameViewModel()
}


// MARK: - Body
extension GameContainerView {

    var body: some View {
        GameView(viewModel: gameViewModel)
            .onAppear {
                self.loadWords()
            }
    }
}


// MARK: - Private Helpers
extension GameContainerView {
    
    private func loadWords() {
        Bundle.main.createString(fromFileNamed: "game-words", withExtension: "txt") { result in
            switch result {
            case .success(let string):
                self.gameViewModel.allRootWords = string.components(separatedBy: "\n")
                self.gameViewModel.startNewRound()
            case .failure:
                fatalError()
            }
        }
    }
}


// MARK: - Preview
struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        return GameContainerView(gameViewModel: GameViewModel(rootWords: sampleWords))
    }
}

```

여기는 짧아서 한번에 ㅎㅎ 
아까 우리가 만들어준 GameView를 이용해서 뷰를 구성하는 부분입니다. 
사실 뷰 구성 요소는 추가된게 없는데, MVVM으로 뷰를 구성하기 위해서 이렇게 만든 것 같아요.




