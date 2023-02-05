//
//  ViewController.swift
//  5330_assignment3
//
//  Created by Mark Gamble on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    // create a timer
    var timer = Timer()

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
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.updateDateTime() })
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

