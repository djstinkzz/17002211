//
//  ViewController.swift
//  Petestestgame
//
//  Created by Pete Smith on 08/06/2020.
//  Copyright © 2020 Pete Smith. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

protocol subviewDelegate{
func releaseBall()
func startup()
func updateDirection(dx:CGFloat, dy:CGFloat , center: CGPoint)
}
    class ViewController: UIViewController, subviewDelegate{
    //Variables for the game
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var collisionBehavior: UICollisionBehavior!
    var birdcollisonBehavior: UICollisionBehavior!
    var ballImage: Array<UIImageView> = []
    var birdViewArray: [UIImageView]  = []
    var Score = 0
    var releaseDirection: CGPoint!
    var angleX: CGFloat!
    var angleY: CGFloat!
    var timer:Timer?
    var seconds = 20
    
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    //Global variables for screenfit programming
    //Array containing all the bird images
    let birdArray = [UIImage(named: "bird1.png")!,
                     UIImage(named: "bird2.png")!,
                     UIImage(named: "bird3.png")!,
                     UIImage(named: "bird4.png")!,
                     UIImage(named: "bird5.png")!,
                     UIImage(named: "bird6.png")!,
                     UIImage(named: "bird7.png")!,
                     UIImage(named: "bird9.png")!,
                     UIImage(named: "bird10.png")!,
                     UIImage(named: "bird11.png")!,
                     UIImage(named: "bird12.png")!,
                     UIImage(named: "bird13.png")!
    ]
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.startup()
        updateTimeLabel() //calling the function in the view
        self.view.backgroundColor = UIColor.white //background colour
        
    }
        override func didReceiveMemoryWarning() {
                   super.didReceiveMemoryWarning()
    }
        func startup(){
        MusicPlayer.shared.startBackgroundMusic()   // function that calls the MusicPlayer class to start game music
        score.text = "Score: " + String(Score)
            
        self.createBirdImage()  //bird creation function
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
            
        shooter.frame = CGRect(x:W*0.02, y: H*0.4, width: W*0.2, height: H*0.2)
        shooter.myDelegate = self
            
        birdcollisonBehavior = UICollisionBehavior(items: birdViewArray)
            
        self.birdcollisonBehavior.action = {
            for ballView in self.ballImage {
                for birdView in self.birdViewArray {
                    let index = self.birdViewArray.firstIndex(of: birdView)
                    if ballView.frame.intersects(birdView.frame) {
                            birdView.removeFromSuperview()
                            self.birdViewArray.remove(at: index!)
                    }
                    if self.birdViewArray.contains(birdView) == false {
                    self.Score = self.Score + 1
                    }
                }
            }
        self.score.text = "Score: " + String(self.Score)
    }
            dynamicAnimator.addBehavior(birdcollisonBehavior)
}
        func updateDirection(dx: CGFloat, dy: CGFloat, center: CGPoint) {
            angleX = dx
            angleY = dy
            releaseDirection = center
    }
        func releaseBall() {    //function to release ball
            let ball = UIImageView(image:nil)
            ball.image = UIImage(named: "ball.png")
            ball.frame = CGRect(origin: releaseDirection, size: CGSize(width: W*0.05, height: H*0.1))
            self.view.addSubview(ball)
            ballImage.append(ball)
          
            dynamicItemBehavior = UIDynamicItemBehavior(items: ballImage)
            self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: angleX, y: angleY), for: ball)
            dynamicAnimator.addBehavior(dynamicItemBehavior)
    
            collisionBehavior = UICollisionBehavior(items:ballImage)
            collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10000))
    
            dynamicAnimator.addBehavior(collisionBehavior)
            //Initiation of Timer
                if timer == nil {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
                
                if self.seconds == 0 {
                    self.finishGame()
                } else if self.seconds <= 20 {  //determining the time of the game
                    self.seconds -= 1
                    self.updateTimeLabel()
                }
            }
        }
    }
            func createBirdImage(){ //produces targets from array
                let amount = 5
                let birdSize = Int(self.H)/amount-2

                for index in 0...1000{
                    let when = DispatchTime.now() + (Double(index)/2)
                    DispatchQueue.main.asyncAfter(deadline: when) {
    
                while true {
                                   
                    let randomHeight = Int(self.H)/amount * Int.random(in: 0...amount)
                    let birdView = UIImageView(image: nil)
                                   
                    birdView.image = self.birdArray.randomElement()
                    birdView.frame = CGRect(x: self.W-CGFloat(birdSize), y:  CGFloat(randomHeight), width: CGFloat(birdSize),
                    height: CGFloat(birdSize))
                                   
                    self.view.addSubview(birdView)
                    self.view.bringSubviewToFront(birdView)
                                   
                    for anyBirdView in self.birdViewArray {
                        if birdView.frame.intersects(anyBirdView.frame) {
                            birdView.removeFromSuperview()
                            continue
                        }
                    }
                                   
                    self.birdViewArray.append(birdView)
                    break;
                }
            }
        }
    }
    
       
    
                @IBOutlet weak var shooter: DragImageView!//links main.storyboard shooter image with Cocoa touch class
    
                @IBOutlet weak var score: UILabel!  //links main.storyboard label to viewController class

                @IBOutlet weak var timerLabel: UILabel! //links main.storyboard label to viewController class
    
                func updateTimeLabel() {    //function that adds time to the game 
         
                        let min = (seconds / 60) % 60
                        let sec = seconds % 60
         
                        timerLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
     }
     
            func finishGame()  //function that triggers the gameover alert
     {
                    timer?.invalidate ()
                    timer = nil
         
                    let alert = UIAlertController(title: "Game Over!", message: "Your time is up! You got a \(Score) points!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))
         
                    self.present(alert, animated: true, completion: nil)
         
                    Score = 0
                    seconds = 20
    
                    updateTimeLabel()
    
         
     }

    
                class PauseVC: UIViewController {
                @IBOutlet weak var lblScore: UILabel!
   
    
                    override func viewDidLoad() {
                        super.viewDidLoad()
                        // Do any additional setup after loading the view.
    }
                    override func viewWillAppear(_ animated: Bool) {
                        super.viewWillAppear(true)
                        getUserScoreAndLevel()
    }
                func getUserScoreAndLevel(){
                        if let Score = UserDefaults.standard.string(forKey: "Score"){
                            self.lblScore.text = Score
        }
}
    
    }
}

