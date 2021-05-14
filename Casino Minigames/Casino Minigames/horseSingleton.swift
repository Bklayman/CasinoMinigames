//
//  horseSingleton.swift
//  Casino Minigames
//
//  Created by Randy Giron on 5/14/21.
//
import UIKit

class WinningHorse {
    static let sharedHorseWin = WinningHorse()
    
    private init() {}
    
    func printhorse() {
        //print("Horse Update")
    }
    func startRace() {
        horseRaceStart = true;
        wonhorse = 0;
    }
    func stopRace() {
        horseRaceStart = false;
    }
    func horseWin(horse: Int) {
        wonhorse = horse + 1
    }
    
    var wonhorse = 0;
    var horseRaceStart = false;
}
