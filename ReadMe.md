# Top Brains
An iOS game written in Swift that trains your brain and hand-eye coordination as my final project for my Mobile Development 1.1 course in Make School. It follows best practices in Model View Controller pattern to avoid massive view controllers. Separation of concerns, using __enumaration__ to keep track of game's current state and difficulty, __[protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)__ like [CaseIterable](https://www.hackingwithswift.com/example-code/language/how-to-list-all-cases-in-an-enum-using-caseiterable) be able to use allCases method to select a random case for Color, [String](https://swiftdoc.org/v4.2/protocol/stringprotocol/) for case's rawValue, and some custom protocols

## Features
- Different game difficulties
- High score functionality for each difficulties
- Basic animations
- Transition animations

## Game Play
### MenuVC: User can select from 3 difficulties:
- Easy: White Cards
- Medium: White and Black Cards
- Hard: Green, Red, Black, and White Cards
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/menu.gif" width="563" height="1000">

### Easy: Top card TEXT must match the bottom card's TEXTCOLOR
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/easy.gif" width="563" height="1000">

### Medium: Black cards's answer is opposite of white's answer
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/medium.gif" width="563" height="1000">

### Hard: Green means yes, and red means no, with black and white cards rules
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/hard.gif" width="563" height="1000">

-----

## App Inspiration
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/screenshots/sampleGame.png" width="450" height="609">


## Contributors

Contributions are welcome! Please see our [Contributing Guide](https://github.com/SamuelFolledo/TopBrains) for more details.

<table>
  <tr>
      <td align="center"><a href="https://github.com/SamuelFolledo"><img src="https://avatars3.githubusercontent.com/u/30268383?s=460&v=4" width="75px;" alt=Samuel P. Folledo/><br /><sub><b>Samuel P. Folledo</b></sub></a><br/></td>
        <td align="center"><a href="https://github.com/mdrame"><img src="https://avatars2.githubusercontent.com/u/12403216?s=400&u=9875abe868dfe18624d73555980c62e0e346e1ce&v=4" width="75px;" alt="Mohammed Drame (iOS Developer / Student @ MakeSchool) "/><br /><sub><b>Mohammed Drame</b></sub></a><br/></td>
    </tr>  
</table>

## 📝 License

By contributing, you agree that your contributions will be licensed under its MIT License.

In short, when you submit code changes, your submissions are understood to be under the same [MIT License](LICENSE) that covers the project. Feel free to contact the maintainers if that's a concern.
