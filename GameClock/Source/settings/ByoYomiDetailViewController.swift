//
//  ByoYomiDetailViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/14/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

class ByoYomiDetailViewController : DetailViewController, HMSPickerDelegate, BYPickerDelegate  {
    @IBOutlet weak var hmsPicker: HMSPicker!
    @IBOutlet weak var byoyomiPicker: ByoYomiPicker!
    public var mainTime : Int = 300 {
        willSet(newTime) {
            hmsPicker.time = newTime
        }
    }
    public var byoYomiTime : Int = 20 {
        willSet(newTime) {
            byoyomiPicker.time = newTime
        }
    }
    public var numPeriods : Int = 5 {
        willSet(newNumPeriods) {
            byoyomiPicker.numPeriods = newNumPeriods
        }
    }

    override var phases: [Phase] {
        let aPhase = AbsolutePhase(time: mainTime)
        let bPhase = ByoYomiPhase(time: byoYomiTime, numPeriods: numPeriods)
        return [aPhase, bPhase]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hmsPicker.translatesAutoresizingMaskIntoConstraints = false
        hmsPicker.hmsDelegate = self
        hmsPicker.time = mainTime
        byoyomiPicker.translatesAutoresizingMaskIntoConstraints = false
        byoyomiPicker.byDelegate = self
        byoyomiPicker.time = byoYomiTime
        byoyomiPicker.numPeriods = numPeriods
    }

    func timeSelected(seconds: Int) {
        mainTime = seconds
    }

    func timeSelected(time: Int, numPeriods: Int) {
        byoYomiTime = time
        self.numPeriods = numPeriods
    }
}
