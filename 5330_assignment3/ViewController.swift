//
//  ViewController.swift
//  5330_assignment3
//
//  Created by Mark Gamble on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    // create a CurrentTimer
    var CurrentTimer = Timer()
    var Countdown = Timer()
    // create a variable to hold the time remaining
    var remaining = 0

    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var TimeRemaining: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var DateTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }

    func updateDateTime() {
        // set the date and time
        let date = Date()
        let formatter = DateFormatter()
        // set the format to be like "Sun, 5 Feb 2023 12:34:56"
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss"
        DateTime.text = formatter.string(from: date)
    }
}

