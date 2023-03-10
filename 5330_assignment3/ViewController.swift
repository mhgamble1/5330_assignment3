//
//  ViewController.swift
//  5330_assignment3
//
//  Created by Mark Gamble on 2/5/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var CurrentTimer = Timer()
    var timer = Timer()
    var count: Int = 60
    var timerOn: Bool = false
    var musicOn: Bool = false
    var player: AVAudioPlayer?

    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var TimeRemaining: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var DateTime: UILabel!
    override func viewDidLoad() {

        super.viewDidLoad()
        // set the date and time
        let date = Date()
        let formatter = DateFormatter()
        // set the format to be like "Sun, 5 Feb 2023 12:34:56"
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss"
        DateTime.text = formatter.string(from: date)
        CurrentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.updateDateTime() })
        // set the background image to day.jpg if it is day time and night.jpg if it is night time
        let hour = Calendar.current.component(.hour, from: date)
        if hour >= 6 && hour < 18 {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "day.jpg")!)
        } else {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "night.jpg")!)
        }
        print("hello")
    }

    func updateDateTime() {
        let date = Date()
        let formatter = DateFormatter()
        // set the format to be like "Sun, 5 Feb 2023 12:34:56"
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss"
        DateTime.text = formatter.string(from: date)
    }

    @IBAction func StartStopPressed(_ sender: Any) {
        if !timerOn && !musicOn {
            timerOn = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        } else if !timerOn && musicOn{
            musicOn = false
            timerOn = false
            StartStopButton.setTitle("Start Timer", for: .normal)
        } else {
            timer.invalidate()
            timerOn = false
            StartStopButton.setTitle("Stop Music", for: .normal)
        }
    }

    @objc func timerCounter() -> Void {
        if count == 0 {
            timer.invalidate()
            timerOn = false
            print("play song")
            StartStopButton.setTitle("Stop Music", for: .normal)
            musicOn = true
            guard let url = Bundle.main.url(forResource: "song", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)            
                try AVAudioSession.sharedInstance().setActive(true)

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
            count = 60
            StartStopButton.setTitle("Start Timer", for: .normal)
            return
        }
        count = count - 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = formatTime(hours: time.0, minutes: time.1, seconds: time.2)
        TimeRemaining.text = timeString
    }

    // convert seconds to hours, minutes, and seconds
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }

    // create a formatted string from the hours, minutes, and seconds like "01:23:45"
    func formatTime(hours: Int, minutes: Int, seconds: Int) -> String {
        return String(format: "Time Remaining: %02d:%02d:%02d", hours, minutes, seconds)
    }

    @IBAction func DPChanged(_ sender: Any) {
        print("DPChanged")
        // set count to the value of the date picker
        count = Int(DatePicker.countDownDuration)
    }
}

