//
//  ViewController.swift
//  Hangman
//
//  Created by Iryna Nikitsenka on 2024-10-09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var winsLabel: UILabel!
    
    @IBOutlet weak var lossesLabel: UILabel!
    
    @IBOutlet var charViews: [UIView]!
    
    @IBOutlet var charLabels: [UILabel]!
    
    @IBOutlet var keyButtons: [UIButton]!
    
    var winsCount = 0
    var lossesCount = 0
    
    var words = ["Journey", "Rainbow", "Giraffe", "Holiday", "Success",
                 "Pumpkin", "Tractor", "Mystery", "Project", "Horizon",
                 "Tornado", "Ketchup", "Benefit", "Harvest", "Wildcat",
                 "Caramel", "Sparkle", "Quality", "Courage", "Justice",
                 "Opinion", "Pioneer", "Respect", "Victory", "Baggage",
                 "Harmony", "Liberty", "Network", "Glucose", "Insider",
                 "Octagon", "Unicorn", "Dolphin", "Eclipse", "Freedom",
                 "Elegant", "Popular", "Popular", "Natural", "Bedroom",
                 "Control", "Account", "Miracle", "Automat", "Booster",
                 "Display", "Meeting", "Booklet", "Married", "Caption"]
    var word = ""
    
    var errorsCount = 0
    var charsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        
        setGame()
    }

    // Apply additional style
    func setStyle() {
        for view in charViews {
            view.layer.borderWidth = 1.5
            view.layer.borderColor = UIColor.black.cgColor
        }
        for button in keyButtons {
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
        }
    }
    
    // Create a new game
    func setGame() {
        word = (words.randomElement() ?? "hangman").uppercased()
        
        errorsCount = 0
        charsCount = 0
        
        imageView.image = UIImage(named: "start")
        
        for label in charLabels {
            label.text = "_"
        }
        
        for button in keyButtons {
            button.layer.borderColor = UIColor.black.cgColor
            //button.backgroundColor = nil
            button.isEnabled = true
        }
    }
    
    // Check the letter in the word
    func check(char: Character) -> [Int] {
        var indexes: [Int] = []
        for (index, value) in Array(word).enumerated() {
            if value == char {
                indexes.append(index)
            }
        }
        return indexes
    }
    
    // Handler for creating a new game
    func yesActionHandler(_ action: UIAlertAction) {
        setGame()
    }
    
    // Show an alert
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: yesActionHandler)
        
        let noAction = UIAlertAction(title: "No", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
    }
    
    // Handler for checking a letter
    @IBAction func keyPressed(_ sender: UIButton) {
        let char = sender.titleLabel?.text ?? ""
        let result = check(char: Character(char))
        for index in result {
            charLabels[index].text = char
            charsCount += 1
        }
        
        if charsCount == 7 {
            winsCount += 1
            winsLabel.text = "WINS: \(winsCount)"
            imageView.image = UIImage(named: "saved")
            showMessage(title: "Woohoo!", message: "You saved me! Would you like to play again?")
        }
        
        if result.count == 0 {
            errorsCount += 1
            imageView.image = UIImage(named: "hangman\(errorsCount)")
        }
        
        if errorsCount > 5 {
            lossesCount += 1
            lossesLabel.text = "LOSSES: \(lossesCount)"
            imageView.image = UIImage(named: "dead")
            showMessage(title: "Uh oh", message: "The correct word was \(word). Would you like to try again?")
        }
        
        sender.layer.borderColor = result.count > 0 ? UIColor(named: "right")?.cgColor : UIColor(named: "wrong")?.cgColor
        //sender.backgroundColor = result.count > 0 ? UIColor(named: "right") : UIColor(named: "wrong")
        sender.isEnabled = false
    }
}

