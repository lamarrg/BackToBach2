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
    
    
    @IBOutlet weak var topNav: UINavigationItem!
    
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
        timer.invalidate()
        player.currentTime = 0
        sliderScrubber.value = 0
    }
    
    
    @IBAction func scrubSong(sender: AnyObject) {
        
        player.currentTime = Double(sliderScrubber.value)
        
        if player.playing {
            
            player.play()
        
        }
        
    }
    
    
    @IBAction func changeVolume(sender: AnyObject) {
        
        player.volume = sliderVolume.value
        
    }
    

    func updateScrubSlider(){
        
        sliderScrubber.value = Float(player.currentTime)
        print(player.currentTime)
        
        
        if ((player.currentTime + 1.0) >= player.duration) {
            
            timer.invalidate()
            sliderScrubber.value = 0.0
        
        }
        
    }
    
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateScrubSlider)), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topNav.title = "Attack of the Killer Bees"
        
        let audioPath = NSBundle.mainBundle().pathForResource("Attack of the Killer Bees", ofType: "mp3")
        
        do
        
        {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            
            sliderScrubber.maximumValue = Float(player.duration)
        
        } catch {
            
            // error stuff here
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

