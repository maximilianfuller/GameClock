//
//  AbsoluteSettingsViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/13/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

class AbsoluteDetailViewController : DetailViewController, HMSPickerDelegate, IncrementPickerDelegate {
    @IBOutlet weak var hmsPicker: HMSPicker!
    @IBOutlet weak var incrementPicker: IncrementPicker!
    var time : Int = 300 {
        willSet(newTime) {
            hmsPicker.time = newTime
        }
    }
    var increment : Int = 0 {
        willSet(newIncrement) {
            incrementPicker.time = newIncrement
            incrementPicker.isHidden = newIncrement == 0
        }
    }

    override var phases: [Phase] {
        if increment == 0 {
            return [AbsolutePhase(time: time)]
        }
        return [IncrementPhase(time: time, increment: increment)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hmsPicker.translatesAutoresizingMaskIntoConstraints = false
        hmsPicker.hmsDelegate = self
        hmsPicker.time = time
        incrementPicker.translatesAutoresizingMaskIntoConstraints = false
        incrementPicker.time = increment
        incrementPicker.incrementDelegate = self
        incrementPicker.isHidden = increment == 0
    }

    @IBAction func toggleIncrement(_ sender: UISwitch) {
        incrementPicker.isHidden = !sender.isOn
    }

    func timeSelected(seconds: Int) {
        time = seconds
    }

    func timeSelected(increment: Int) {
        self.increment = increment
    }

}
