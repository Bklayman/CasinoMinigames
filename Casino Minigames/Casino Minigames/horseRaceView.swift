//
//  DrawingView.swift
//  Custom_Drawing
//
//  Created by Randy Giron on 3/1/21.
//  Copyright © 2021 Ranvspeed Giron. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

class HorseRaceView: UIView {
    
    
    var drawx = Array(repeating: 0, count: 4)
    var drawy = Array(repeating: 0, count: 4)
    var hspeed = Array(repeating: 1, count: 4)
    var vspeed = Array(repeating: 0, count: 4)
    
    let imageView = UIImageView(image: UIImage(named: "horse.png"))
    let imageView2 = UIImageView(image: UIImage(named: "horse.png"))
    let imageView3 = UIImageView(image: UIImage(named: "horse.png"))
    let imageView4 = UIImageView(image: UIImage(named: "horse.png"))
    
    override func draw(_ rect: CGRect) {
        //let context = UIGraphicsGetCurrentContext()
        
        //self.backgroundColor = UIColor.blue
        //imageView.removeFromSuperview()
        
        //let color:UIColor = UIColor.yellow
        //for n in 0...3 {
            
            imageView.frame = CGRect(x: drawx[0], y: drawy[0], width: 100, height: 100)
            self.addSubview(imageView)
            imageView2.frame = CGRect(x: drawx[1], y: 100, width: 100, height: 100)
            self.addSubview(imageView2)
            imageView3.frame = CGRect(x: drawx[2], y: 200, width: 100, height: 100)
            self.addSubview(imageView3)
            imageView4.frame = CGRect(x: drawx[3], y: 300, width: 100, height: 100)
            self.addSubview(imageView4)
            
        //}
        
        //NSLog("DrawRect called")
        
    }

    @objc func update() {
        //print("Drawview Update")
        
        drawx = drawx + hspeed
        drawy = drawy + vspeed
        
        //var horseExitCount = 0
        
        for n in 0...3 {
            drawx[n] = drawx[n] + hspeed[n]
            drawy[n] = drawy[n] + vspeed[n]
            
            if Int.random(in: 1...60) == 60 {
                hspeed[n] += Int.random(in: -1...1)
            }
            if hspeed[n] < -1 {
                hspeed[n] = -1
            }
            
            if drawx[n] < 0 {
                hspeed[n] = -hspeed[n]
            }
            if drawy[n] < 0 {
                vspeed[n] = -vspeed[n]
            }
            if drawx[n] > (Int(self.bounds.maxX)) {
                //hspeed[n] = -hspeed[n]
                
                /*
                if WinningHorse.sharedHorseWin.wonhorse == 0 {
                    WinningHorse.sharedHorseWin.wonhorse = n + 1
                }
                */
                
                WinningHorse.sharedHorseWin.horseWin(horse: n)
            }
            if drawy[n] > (Int(self.bounds.maxY) - 50) {
                vspeed[n] = -vspeed[n]
            }
        }
        
        setNeedsDisplay()
        
    }
    
    func startRace() {
        for n in 0...3 {
            drawy[n] = 100*n;
            drawx[n] = 0;
            hspeed[n] = Int.random(in: 1...3)
        }
    }
}

