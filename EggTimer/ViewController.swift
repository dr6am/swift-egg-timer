//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime:[String:Int] = [
        "Soft":300,
        "Medium":420,
        "Hard":720,
    ]
    
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    
    @IBAction func hardnessSelection(_ sender:UIButton){
        titleLabel.text = "How do you like your eggs?"
        timer.invalidate()
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateTimer(){
        if totalTime > secondPassed {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
             
        }else{
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

               do {
                   try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                   try AVAudioSession.sharedInstance().setActive(true)

                   player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                   guard let player = player else { return }

                   player.play()

               } catch let error {
                   print(error.localizedDescription)
               }
            timer.invalidate()
            titleLabel.text = "DONE!"
        }
    }
    
}
