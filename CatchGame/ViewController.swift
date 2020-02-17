//
//  ViewController.swift
//  CatchGame
//
//  Created by USER on 23.01.2020.
//  Copyright © 2020 Furkan Basoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //variable
    var score = 0
    var timer = Timer()
    var counter = 0
    var waspArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel! //time label(30)
    @IBOutlet weak var scoreLabel: UILabel! //score label
    @IBOutlet weak var highscoreLabel: UILabel! //hihgscore label
    
    //image views
    @IBOutlet weak var wasp1: UIImageView!
    @IBOutlet weak var wasp2: UIImageView!
    @IBOutlet weak var wasp3: UIImageView!
    @IBOutlet weak var wasp4: UIImageView!
    @IBOutlet weak var wasp5: UIImageView!
    @IBOutlet weak var wasp6: UIImageView!
    @IBOutlet weak var wasp7: UIImageView!
    @IBOutlet weak var wasp8: UIImageView!
    @IBOutlet weak var wasp9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newscore = storedHighscore as? Int{
            highScore = newscore
            highscoreLabel.text = "Highscore: \(highScore)"
        }

        wasp1.isUserInteractionEnabled = true //kullanıcının imageların üzerine tıklamasını etkin hale getiriyoruz
        wasp2.isUserInteractionEnabled = true
        wasp3.isUserInteractionEnabled = true
        wasp4.isUserInteractionEnabled = true
        wasp5.isUserInteractionEnabled = true
        wasp6.isUserInteractionEnabled = true
        wasp7.isUserInteractionEnabled = true
        wasp8.isUserInteractionEnabled = true
        wasp9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        wasp1.addGestureRecognizer(recognizer1)
        wasp2.addGestureRecognizer(recognizer2)
        wasp3.addGestureRecognizer(recognizer3)
        wasp4.addGestureRecognizer(recognizer4)
        wasp5.addGestureRecognizer(recognizer5)
        wasp6.addGestureRecognizer(recognizer6)
        wasp7.addGestureRecognizer(recognizer7)
        wasp8.addGestureRecognizer(recognizer8)
        wasp9.addGestureRecognizer(recognizer9)
        
        waspArray = [wasp1, wasp2, wasp3, wasp4, wasp5, wasp6, wasp7, wasp8, wasp9]
        
        //Timer
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideWaspImage), userInfo: nil, repeats: true)
        
        hideWaspImage()
        
    }
    
    @objc func hideWaspImage(){
        
        for wasp in waspArray{
            wasp.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(waspArray.count - 1))) //random oluşturma
        waspArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate() //timer'ı durduyoruz
            hideTimer.invalidate()
            
            for wasp in waspArray {
                wasp.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highScore{
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (_) in
                
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                //yeniden timer'ı çalıştırmamız gerektiği için burayada yazıyoruz
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideWaspImage), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(noButton)
            alert.addAction(yesButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }


}

