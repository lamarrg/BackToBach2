//
//  ViewController.swift
//  BackToBach2
//
//  Created by Lamar Greene on 1/2/16.
//  Copyright © 2016 Lamar Greene. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()
    var songPosition: Double = 0.0
    var timer: NSTimer!
    
    
    @IBOutlet weak var sliderScrubber: UISlider!
    
    @IBOutlet weak var sliderVolume: UISlider!
    
    
    @IBAction func play(sender: AnyObject) {
        player.play()
        startTimer()
    }
    
    @IBAction func pause(sender: AnyObject) {
        if player.playing {
            player.pause()
            timer.invalidate()
        }


    }
    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        player.currentTime = 0
        timer.invalidate()
        
    }
    
    @IBAction func scrubSong(sender: AnyObject) {
        
        player.currentTime = slideSongPosition()
        
        if player.playing {
            player.play()
        
        }
        
    }
    
    @IBAction func changeVolume(sender: AnyObject) {
        player.volume = sliderVolume.value
    }
    

    func updateScrubSlider(){
        
        sliderScrubber.value = Float((player.currentTime / player.duration) * 100 )
        
        print(sliderScrubber.value)
        print(player.currentTime)
        
        
    }
    
    func slideSongPosition() -> Double {
        
        return (player.duration/100) * Double(sliderScrubber.value)
    }
    
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateScrubSlider"), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let audioPath = NSBundle.mainBundle().pathForResource("killerBs", ofType: "mp3")
        
        do
        
        {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
        
        } catch {
            // error stuff here
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

