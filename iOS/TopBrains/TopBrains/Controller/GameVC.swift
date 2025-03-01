//
//  GameVC.swift
//  TopBrains
//
//  Created by Samuel P. Folledo on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
//MARK: Properties
    var gameState: GameState? {
        didSet {
            switch gameState {
            case .playing:
                playGame()
            case .paused:
                pauseGame()
            case .gameOver:
                gameOver()
            default:
                break
            }
        }
    }
    var gameDifficulty: GameDifficulty?
    var maxTime: Double?
    var timer: Timer?
    var timerCounter: Double? {
        didSet {
            guard let _ = timerCounter else { return }
            timeLabel.text = "\(String(format: "%.1f", timerCounter!))" //round up to 1 decimal place
            if timerCounter! <= 0 {
                timeLabel.text = "0.0"
                gameState = .gameOver
            }
        }
    }
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            guard let _ = maxTime, maxTime! > 1 else { return }
            if score % 3 == 0 { //everytime user scores 3 points, reduce the time. But maxTime will not go lower than 1 seconds
                self.maxTime! -= 0.1
            }
        }
    }
    var pausesLeft: Int? {
        didSet {
            guard let pausesLeft = pausesLeft else { return }
            switch pausesLeft { //different ways to compare switch values
            case let num where num == 0:
                pauseLabel.text = "Warning! This is your last pause"
                pauseLabel.fadeIn(duration: 0.5)
            case _ where pausesLeft < 0:
                gameState = .gameOver
            default:
                pauseLabel.text = "\(String(pausesLeft))x pauses remaining"
                pauseLabel.fadeIn(duration: 0.5)
            }
        }
    }
    
//MARK: IBOutlets
    @IBOutlet weak var topCardView: CardView!
    @IBOutlet weak var bottomCardView: CardView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var isCorrectImageView: UIImageView!
    @IBOutlet weak var pauseLabel: UILabel!
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    private func setupViews() {
        pauseButton.alpha = 0
        isCorrectImageView.isHidden = true
        isCorrectImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        pausesLeft = 3
        guard let gameDifficulty = gameDifficulty else { return }
        maxTime = gameDifficulty.initialMaxTime
        timerCounter = maxTime
        gameState = .playing
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateGameTimer), userInfo: nil, repeats: true) //Once the round is ready, start the timer
    }
    
    private func updateCardColor() {
        let color = Color()
        topCardView.text = color //SET a new random color
        topCardView.colorLabel.textColor = .black //keep this black
        bottomCardView.text = Color() //setting text to a new Color will update the card's text
        bottomCardView.textColor = Bool.random() ? color : Color() //setting color to a new Color will update the card's textColor
        var cardColor: CardColor = CardColor.white
        switch gameDifficulty { //change background
        case .medium: //make a black or white card
            if Bool.random() { //if random Bool is true...
                cardColor = CardColor.black //make the cardBG black
            }
        case .hard: //if hard...
            cardColor = CardColor() //select random color
        default: //else keep card as white
            break
        }
        topCardView.cardColor = cardColor //assign cardColor
        bottomCardView.cardColor = cardColor
    }
    
    private func evaluateAnswer(userSelectedYes: Bool) {
        switch bottomCardView.cardColor { //check card color and evaluate answer
        case .white: //WHITE
            if (topCardView.text == bottomCardView.textColor && userSelectedYes) || (topCardView.text != bottomCardView.textColor && !userSelectedYes) { //if text and color are the equal and user said yes OR if text and color are not equal and user said no
                correctAnswer()
                return
            }
        case .black: //BLACK
            if (topCardView.text == bottomCardView.textColor && !userSelectedYes) || (topCardView.text != bottomCardView.textColor && userSelectedYes) {
                correctAnswer()
                return
            }
        case .green: //GREEN
            if userSelectedYes { //if green card - yes answer
                correctAnswer()
                return
            }
        case .red: //RED
            if !userSelectedYes { //if red card - say no
                correctAnswer()
                return
            }
        }
        gameState = .gameOver
    }
    
    private func correctAnswer() {
        score += 1
        timerCounter = maxTime
        showIsCorrectImageView(isCorrect: true)
        updateCardColor()
    }
    
    private func showIsCorrectImageView(isCorrect: Bool) { //the correct or wrong indicator
        isCorrectImageView.image = isCorrect ? kCORRECTIMAGE : kWRONGIMAGE
        isCorrectImageView.isHidden = false
        isCorrectImageView.enlargeThenShrinkAnimation()
    }
    
    private func pauseGame() {
        pauseButton.setImage(kPLAYIMAGE, for: .normal)
        guard let timer = timer else { return }
        timer.invalidate() //pause the timer
        topCardView.fadeOut(duration: 0.3)
        bottomCardView.fadeOut(duration: 0.3)
        yesButton.fadeOut(duration: 0.3)
        noButton.fadeOut(duration: 0.3)
        yesButton.isEnabled = false
        noButton.isEnabled = false
        guard let _ = pausesLeft else { return }
        self.pausesLeft! -= 1
    }
    
    private func playGame() {
        pauseButton.alpha = 1
        pauseButton.setImage(kPAUSEIMAGE, for: .normal)
        topCardView.fadeIn(duration: 0.3)
        bottomCardView.fadeIn(duration: 0.3)
        yesButton.fadeIn(duration: 0.3)
        noButton.fadeIn(duration: 0.3)
        yesButton.isEnabled = true
        noButton.isEnabled = true
        pauseLabel.fadeOut(duration: 0.3)
        startTimer()
        updateCardColor()
    }
    
    private func gameOver() {
        guard let _ = timer else { return }
        timer!.invalidate()
        showIsCorrectImageView(isCorrect: false) //user answered wrong
        yesButton.isEnabled = false
        noButton.isEnabled = false
        guard let _ = gameDifficulty else { return }
        if score > self.gameDifficulty!.highScore {
            gameDifficulty!.setHighScore(score: score) //score is now our new high score
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //add a 1 sec delay before dismissing
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
//MARK: IBActions
    @IBAction func yesButtonTapped(_ button: UIButton) {
        evaluateAnswer(userSelectedYes: true)
    }
    
    @IBAction func noButtonTapped(_ button: UIButton) {
        evaluateAnswer(userSelectedYes: false)
    }
    @IBAction func pauseButtonTapped(_ button: UIButton) {
        if button.image(for: .normal) == kPLAYIMAGE {
            gameState = .playing //setting gameState will pause or play the game
        } else {
            gameState = .paused
        }
    }
    
//MARK: Helper Methods
    @objc func updateGameTimer() {
        guard let _ = timerCounter else { return }
        timerCounter! -= 0.1
    }
}
