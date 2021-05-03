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
    
    var points = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func spinButtonAction(_ sender: Any) {
        spinNewImages(bet: 10)
    }
    
    @IBAction func spinButtonAction2(_ sender: Any) {
        spinNewImages(bet: 50)
    }

    @IBAction func spinButtonAction3(_ sender: Any) {
        spinNewImages(bet: 100)
    }
    
    func spinNewImages(bet: Int){
        
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
        
        //calculate points
        var curr = 0
        points -= bet
        curr -= bet

        //sevens
        if num1 == 4 && num2 == 4 && num3 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num4 == 4 && num5 == 4 && num6 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num7 == 4 && num8 == 4 && num9 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num1 == 4 && num4 == 4 && num7 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num2 == 4 && num5 == 4 && num8 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num3 == 4 && num6 == 4 && num9 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num2 == 4 && num4 == 4 && num9 == 4 {
            points += bet*7
            curr += bet*7
        }
        if num2 == 4 && num6 == 4 && num7 == 4 {
            points += bet*7
            curr += bet*7
        }
        //3 matches
        if num1 == num2 && num2 == num3 {
            points += bet*3
            curr += bet*3
        }
        if num4 == num5 && num5 == num6 {
            points += bet*3
            curr += bet*3
        }
        if num7 == num8 && num8 == num9 {
            points += bet*3
            curr += bet*3
        }
        if num2 == num4 && num4 == num9 {
            points += bet*3
            curr += bet*3
        }
        if num2 == num6 && num6 == num7 {
            points += bet*3
            curr += bet*3
        }
        if num1 == num4 && num4 == num7 {
            points += bet*3
            curr += bet*3
        }
        if num2 == num5 && num5 == num8 {
            points += bet*3
            curr += bet*3
        }
        if num3 == num6 && num6 == num9 {
            points += bet*3
            curr += bet*3
        }
        
        //display points
        pointsLabel.text = "$\(points)"
        if(curr > 0){
            currLabel.text = "+\(curr)"
        }
        else {
            currLabel.text = "\(curr)"
        }
    }
}
