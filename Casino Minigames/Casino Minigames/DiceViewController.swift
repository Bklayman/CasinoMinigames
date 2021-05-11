//
//  DiceViewController.swift
//  casino2
//
//  Created by Derrick Ryan
//

import UIKit

class DiceViewController: UIViewController {
    
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var currLabel: UILabel!
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    
    var target = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsLabel.text = "$\(Singleton.sharedObject().totalMoney)"
    }
    
    //roll dice with bet amount
    @IBAction func rollButtonAction(_ sender: Any) {
        let text1 = betTextField.text
        let bet = Int32(text1!) ?? 0
        rollDice(bet: bet)
    }
    
    //roll two dice randomly
    func rollDice(bet: Int32) {
        let roll1 = Int.random(in: 1...6)
        let roll2 = Int.random(in: 1...6)
        
        //set images
        dice1.image = UIImage(named: "dice\(roll1)")
        dice2.image = UIImage(named: "dice\(roll2)")
        
        UIView.transition(with: dice1, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        UIView.transition(with: dice2, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
        //display roll
        var curr = Int32(0)
        let roll = roll1 + roll2
        resultLabel.text = "You Rolled \(roll)!"
        
        //determine win or loss
        if(target == 0){
            if(roll == 7 || roll == 11){
                guideLabel.text = "You Win!"
                Singleton.sharedObject().totalMoney += bet
                curr += bet
            }
            else if(roll == 2 || roll == 3 || roll == 12){
                guideLabel.text = "You Lose!"
                Singleton.sharedObject().totalMoney -= bet
                curr -= bet
            }
            else{
                target = roll
                guideLabel.text = "Roll another \(target) to win"
            }
        }
        else{
            if(roll == 7){
                guideLabel.text = "You Lose!"
                Singleton.sharedObject().totalMoney -= bet
                curr -= bet
                target = 0
            }
            else if(target == roll){
                guideLabel.text = "You Win!"
                Singleton.sharedObject().totalMoney += bet
                curr += bet
                target = 0
            }
        }
        
        //display points
        pointsLabel.text = "$\(Singleton.sharedObject().totalMoney)"
        if(curr > 0){
            currLabel.text = "+\(curr)"
        }
        else {
            currLabel.text = "\(curr)"
        }
    }
    
}
