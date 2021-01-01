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
initialize 부분.

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



## Word Scramble: Introduction

From the description:

> The game will show players a random eight-letter word, and ask them to make words out of it.
>
> For example, if the starter word is “alarming” they might spell “alarm”, “ring”, “main”, and so on.

These "words from another word" are also known as [anagrams](https://en.wikipedia.org/wiki/Anagram).

## Introducing List, your best friend

`List`s are essentially SwiftUI's version of UIKit's TableView. But one neat difference is their ability to seamlessly integrate static and dynamic content within the same `List` element:

```swift
List {
    Section(header: Text("Section 1")) {
        Text("Static row 1")
        Text("Static row 2")
    }

    Section(header: Text("Section 2")) {
        ForEach(0..<5) {
            Text("Dynamic row \($0)")
        }
    }

    Section(header: Text("Section 3")) {
        Text("Static row 3")
        Text("Static row 4")
    }
}
```

Oh... and, that tight integration with the `Section` element is pretty sweet, too 🙂.


## Loading resources from your app bundle

Whenever we have something in our app's `Bundle` that we want to deal with in code, we first need to locate it with a URL (which is why it's called a "Uniform Resource Locator").

In many cases, we'd use this URL to create an instance of `Data`, and then decode that data into some kind of structured model based upon the structure of the file.

In this app, though, we'll be grabbing the contents of a plain-text file that lacks the structure of something like JSON.


Fortunately, because Swift `String`s are weapons-grade, we can also create them directly from the content's of a file:

```swift
if let fileContents = try? String(contentsOf: fileURL) {
    // we loaded the file into a string!
}
```


