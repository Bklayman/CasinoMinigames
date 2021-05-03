//
//  ViewController.swift
//  Custom_Drawing
//
//  Created by Randy Giron on 3/1/21.
//  Copyright © 2021 Randy Giron. All rights reserved.
//

import UIKit

class WinningHorse {
    static let sharedHorseWin = WinningHorse()
    
    var wonhorse = 0;
    var horseRaceStart = false
}

class HorseRaceController: UIViewController {
    
    @IBOutlet weak var horseView: HorseRaceView!
    @IBOutlet weak var horseRaceLabel: UILabel!
    
    @IBOutlet weak var horseBetNumberText: UITextField!
    @IBOutlet weak var horseBetWagerText: UITextField!
    
    @IBOutlet var raceButton: UIButton!
    
    static let shared = ViewController()

    var wager:Int = 0
    var wagerOdds:Int = 4
    var decidedHorse:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
            displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        
    }
    
    @objc func update() {
        print("Update")
        if WinningHorse.sharedHorseWin.horseRaceStart == true {
            horseView.update()
        }
        horseText()
        
        //self.scoreLabel.text = "Score: \(self.score)"
    }
    
    @IBAction func startHorseRace() {
        WinningHorse.sharedHorseWin.horseRaceStart = true;
        
        let text = horseBetNumberText.text
        decidedHorse = Int(text!) ?? 0
        let ttext = horseBetWagerText.text
        wager = Int(ttext!) ?? 0
        WinningHorse.sharedHorseWin.wonhorse = 0
        
        horseView.startRace()
    }
    
    func horseText() {
        if WinningHorse.sharedHorseWin.wonhorse == 0 {
            self.horseRaceLabel.text = "Bet on a horse and enter your wager"
        } else {
            if (self.decidedHorse == WinningHorse.sharedHorseWin.wonhorse) {
                self.horseRaceLabel.text = "Horse \(WinningHorse.sharedHorseWin.wonhorse) wins! You won $\(self.wager * self.wagerOdds)"
            } else {
                self.horseRaceLabel.text = "Horse \(WinningHorse.sharedHorseWin.wonhorse) wins! Try Again!"
            }
        }
    }
    
    func horseWin(horse: Int) {
        
        WinningHorse.sharedHorseWin.horseRaceStart = false;
        
            //horseRaceLabel?.text = "Horse \(wonhorse) wins!"//mess
        //}//mess
        //horseText()
    }
    
    //self.displayScore()
    
}

