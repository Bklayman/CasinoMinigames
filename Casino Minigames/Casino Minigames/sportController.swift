//
//  sportController.swift
//  Casino Minigames
//
//  Created by Randy Giron on 5/13/21.
//

import UIKit

class WinningTeam {
    static let sharedTeamWin = WinningTeam()
    
    var homeScore = 0;
    var awayScore = 0;
    var wonteam = "None";
    var gameStart = false
    var shootingTeam = "None"
    
}

class SportController: UIViewController {
    
    @IBOutlet weak var sportView: SportView!
    @IBOutlet weak var sportLabel: UILabel!
    
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sharedCashLabel: UILabel!
    
    @IBOutlet weak var sportWagerText: UITextField!
    @IBOutlet var sportButton: UIButton!
    
    static let shared = SportController()
    
    var wager:Int = 0
    var wagerOdds:Int = 2
    var decidedTeam = "None"
    var paymentRec = false;
    
    var timer = Timer()
    var timeLeft = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
            displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        
    }
    
    @objc func update() {
        print("Update")
        if WinningTeam.sharedTeamWin.gameStart == true {
            sportView.update()
        }
        self.sportText()
        
        //WinningTeam.sharedTeamWin.homeScore += 1;
    }
    
    @IBAction func startSportGame(_ sender: UIButton) {
        WinningTeam.sharedTeamWin.gameStart = true;
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(scoreEvent), userInfo: nil, repeats: true)
        
        WinningTeam.sharedTeamWin.gameStart = true;
        WinningTeam.sharedTeamWin.wonteam = "None"
        
        timeLeft = 20;
        WinningTeam.sharedTeamWin.homeScore = 0;
        WinningTeam.sharedTeamWin.awayScore = 0;
        
        let ttext = sportWagerText.text
        wager = Int(ttext!) ?? 0
        
        Singleton.sharedObject().totalMoney -= Int32(self.wager)
        
        self.sportText();
        
        paymentRec = false;
        
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc func scoreEvent() {
        
        var pointsScored = 0;
        
        if timeLeft > 0 {
            if WinningTeam.sharedTeamWin.shootingTeam == "Home" {
                pointsScored = Int.random(in: 2...3)
                WinningTeam.sharedTeamWin.homeScore += pointsScored;
                self.gameLabel.text = "The Home Team shoots... and scores \(pointsScored) points!"
                WinningTeam.sharedTeamWin.shootingTeam = "None"
            } else if WinningTeam.sharedTeamWin.shootingTeam == "Away" {
                pointsScored = Int.random(in: 2...3)
                WinningTeam.sharedTeamWin.awayScore += pointsScored;
                self.gameLabel.text = "The Away Team shoots... and scores \(pointsScored) points!"
                WinningTeam.sharedTeamWin.shootingTeam = "None"
            } else if WinningTeam.sharedTeamWin.shootingTeam == "None" {
                if Int.random(in: 1...2) == 1 {
                    WinningTeam.sharedTeamWin.shootingTeam = "Home"
                    self.gameLabel.text = "The Home Team shoots..."
                } else {
                    WinningTeam.sharedTeamWin.shootingTeam = "Away"
                    self.gameLabel.text = "The Away Team shoots..."
                }
            }
            timeLeft -= 1
        } else {
            if WinningTeam.sharedTeamWin.homeScore > WinningTeam.sharedTeamWin.awayScore {
                WinningTeam.sharedTeamWin.wonteam = "Home"
            } else if WinningTeam.sharedTeamWin.homeScore < WinningTeam.sharedTeamWin.awayScore {
                WinningTeam.sharedTeamWin.wonteam = "Away"
            } else {
                WinningTeam.sharedTeamWin.wonteam = "Tie"
            }
            if WinningTeam.sharedTeamWin.wonteam != "Tie" {
                self.gameLabel.text = "The game is over, and the winner is the \(WinningTeam.sharedTeamWin.wonteam) team"
            } else {
                self.gameLabel.text = "The game is over, and it was a tie"
            }
        }
    }
    
    func sportText() {
        var sportLabText = "Bet on a team, place a bet and press start"
        let wteam = WinningTeam.sharedTeamWin.wonteam
        
        self.sharedCashLabel.text = "Current Cash: \(Singleton.sharedObject().totalMoney)"
        
        if self.decidedTeam == "Home" {
            sportLabText = "You bet on the Home Team, "
        } else if self.decidedTeam == "Away" {
            sportLabText = "You bet on the Away Team, "
        }
        
        if WinningTeam.sharedTeamWin.wonteam != "None" {
            if ((WinningTeam.sharedTeamWin.wonteam != "Tie") && (wteam == self.decidedTeam)) {
                sportLabText = sportLabText + "and you guessed correctly, you win $\(self.wager * self.wagerOdds)"
                
                if paymentRec == false {
                    Singleton.sharedObject().totalMoney += Int32(self.wager * self.wagerOdds)
                    paymentRec = true
                }
            } else if ((WinningTeam.sharedTeamWin.wonteam != "Tie") && (wteam != self.decidedTeam)) {
                sportLabText = sportLabText + "and you guessed incorrectly, Try again!"
            } else if WinningTeam.sharedTeamWin.wonteam == "Tie" {
                sportLabText = sportLabText + "and the teams tied, you get your originl wager back."
                
                if paymentRec == false {
                    Singleton.sharedObject().totalMoney += Int32(self.wager)
                    paymentRec = true
                }
            }
        }
        
        self.sportLabel.text = sportLabText
        
        self.homeScoreLabel.text = "Home: \(WinningTeam.sharedTeamWin.homeScore)"
        self.awayScoreLabel.text = "Away: \(WinningTeam.sharedTeamWin.awayScore)"
        
        self.timerLabel.text = "Time Left: \(self.timeLeft):00"
    }
    
    @IBAction func betOnHome() {
        self.decidedTeam = "Home"
    }
    
    @IBAction func betOnAway() {
        self.decidedTeam = "Away"
    }
    
    func gameEnd(horse: Int) {
        
        WinningTeam.sharedTeamWin.gameStart = false;
    }
    
}

