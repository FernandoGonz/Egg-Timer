//
//  ViewController.swift
//  Egg Timer
//
//  Created by Fernando Guerrero G on 06/08/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    /* Times to prepare the egg */
    // let preparationTime: [String: Int] = ["Soft": 5, "Midium": 8, "Hard": 12]
    // I need the minutes in seconds 5 minutes = 300 seconds
    let preparationTime: [String: Int] = ["Soft": 3, "Midium": 4, "Hard": 7]
    
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressBar.progress = 0.0
    }

    @IBAction func eggStyle(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = preparationTime[hardness]!

        progressBar.progress = 0.0
        secondsPassed = 0
        textLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
                print(Float(secondsPassed) / Float(totalTime))
            } else {
                timer.invalidate()
                textLabel.text = "DONE!"
                
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
    
}

