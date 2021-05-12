//
//  SlotsViewController.swift
//  casino
//
//  Created by Derrick Ryan on 4/17/21.
//

import UIKit

class SlotsViewController: UIViewController {

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var currLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsLabel.text = "$\(Singleton.sharedObject().totalMoney)"
    }

    @IBAction func spinButtonAction(_ sender: Any) {
        spinNewImages(bet: Int32(1))
    }
    
    @IBAction func spinButtonAction2(_ sender: Any) {
        spinNewImages(bet: Int32(5))
    }

    @IBAction func spinButtonAction3(_ sender: Any) {
        spinNewImages(bet: Int32(10))
    }
    
    func spinNewImages(bet: Int32){
        
        //generate random numbers
        let num1 = Int.random(in: 1...6)
        let num2 = Int.random(in: 1...6)
        let num3 = Int.random(in: 1...6)
        let num4 = Int.random(in: 1...6)
        let num5 = Int.random(in: 1...6)
        let num6 = Int.random(in: 1...6)
        let num7 = Int.random(in: 1...6)
        let num8 = Int.random(in: 1...6)
        let num9 = Int.random(in: 1...6)
        
        //assign images
        image1.image = UIImage(named: "image\(num1)")
        image2.image = UIImage(named: "image\(num2)")
        image3.image = UIImage(named: "image\(num3)")
        image4.image = UIImage(named: "image\(num4)")
        image5.image = UIImage(named: "image\(num5)")
        image6.image = UIImage(named: "image\(num6)")
        image7.image = UIImage(named: "image\(num7)")
        image8.image = UIImage(named: "image\(num8)")
        image9.image = UIImage(named: "image\(num9)")
        
        //transitions
        UIView.transition(with: image1, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image2, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image3, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image4, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image5, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image6, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image7, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image8, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: image9, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        
        //calculate Singleton.sharedObject().totalMoney
        var curr = Int32(0)
        Singleton.sharedObject().totalMoney -= bet
        curr -= bet

        //sevens
        if num1 == 4 && num2 == 4 && num3 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num4 == 4 && num5 == 4 && num6 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num7 == 4 && num8 == 4 && num9 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num1 == 4 && num4 == 4 && num7 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num2 == 4 && num5 == 4 && num8 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num3 == 4 && num6 == 4 && num9 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num2 == 4 && num4 == 4 && num9 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        if num2 == 4 && num6 == 4 && num7 == 4 {
            Singleton.sharedObject().totalMoney += bet*7
            curr += bet*7
        }
        //3 matches
        if num1 == num2 && num2 == num3 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num4 == num5 && num5 == num6 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num7 == num8 && num8 == num9 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num2 == num4 && num4 == num9 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num2 == num6 && num6 == num7 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num1 == num4 && num4 == num7 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num2 == num5 && num5 == num8 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        if num3 == num6 && num6 == num9 {
            Singleton.sharedObject().totalMoney += bet*4
            curr += bet*4
        }
        
        //display Singleton.sharedObject().totalMoney
        pointsLabel.text = "$\(Singleton.sharedObject().totalMoney)"
        if(curr > 0){
            currLabel.text = "+\(curr)"
        }
        else {
            currLabel.text = "\(curr)"
        }
    }
}
