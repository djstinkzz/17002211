//
//  MusicPlayer.swift
//  Martogame
//
//  Created by MyMac on 09/02/2020.
//  Copyright © 2020 Martogame. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class MusicPlayer: UIImageView {

    
        static let shared = MusicPlayer() 
        var audioPlayer: AVAudioPlayer?

        func startBackgroundMusic() {   //function to start game music
            if let bundle = Bundle.main.path(forResource: "soundName", ofType: "mp3") { //links the mp3 to MusicPlayer class
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                    guard let audioPlayer = audioPlayer else { return }
                    audioPlayer.numberOfLoops = -1  //puts mp3 in loop for continuous music
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch {
                    print(error)
                }
            }
        }
    }
