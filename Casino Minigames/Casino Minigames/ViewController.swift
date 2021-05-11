//
//  ViewController.swift
//  Casino Minigames
//
//  Created by Brendan Klayman on 4/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holdemButton: UIButton!
    @IBOutlet var blackjackButton: UIButton!
    @IBOutlet var slotButton: UIButton!
    @IBOutlet var horseButton: UIButton!
    @IBOutlet var diceButton: UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        casinoBackground();
        
        holdemButton.frame = CGRect(x: 7, y: 300, width: 400, height: 100)
        blackjackButton.frame = CGRect(x: 7, y: 420, width: 400, height: 100)
        slotButton.frame = CGRect(x: 7, y: 540, width: 400, height: 100)
        horseButton.frame = CGRect(x: 7, y: 660, width: 400, height: 100)
        diceButton.frame = CGRect(x: 7, y: 780, width: 400, height: 100)
    }

    func casinoBackground(){
        let background = UIImage(named: "Casino_bg.jpg")

        var casinoBGView : UIImageView!
        casinoBGView = UIImageView(frame: view.bounds)
        casinoBGView.contentMode =  UIView.ContentMode.scaleAspectFill
        casinoBGView.clipsToBounds = true
        casinoBGView.image = background
        casinoBGView.center = view.center
        view.addSubview(casinoBGView)
        self.view.sendSubviewToBack(casinoBGView)
    }

}

