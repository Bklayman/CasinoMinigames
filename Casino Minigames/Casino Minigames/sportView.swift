//
//  sportView.swift
//  Casino Minigames
//
//  Created by Randy Giron on 5/13/21.
//

import SwiftUI
import Foundation
import UIKit

class SportView: UIView {
    
    let imageView = UIImageView(image: UIImage(named: "Basketball.png"))
    let imageView2 = UIImageView(image: UIImage(named: "Basketball.png"))
    
    override func draw(_ rect: CGRect) {
        
        let homeX = 10
        let awayX = 250
        var homeY = 150
        var awayY = 150
        
        if WinningTeam.sharedTeamWin.shootingTeam == "Home" {
            homeY = 100
        } else if WinningTeam.sharedTeamWin.shootingTeam == "Away" {
            awayY = 100
        }
        
        imageView.frame = CGRect(x: homeX, y: homeY, width: 100, height: 200)
        self.addSubview(imageView)
        imageView2.frame = CGRect(x: awayX, y: awayY, width: 100, height: 200)
        imageView2.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.addSubview(imageView2)
        
    }

    @objc func update() {
        print("Drawview Update")
        setNeedsDisplay()
    }
}

