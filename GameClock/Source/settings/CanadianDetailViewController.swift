//
//  CanadianDetailViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 12/4/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

class CanadianDetailViewController : DetailViewController, HMSPickerDelegate, CanadianDelegate  {
    @IBOutlet weak var hmsPicker: HMSPicker!
    @IBOutlet weak var canadianPicker: CanadianPicker!
    public var mainTime : Int = 300 {
        willSet(newTime) {
            hmsPicker.time = newTime
        }
    }
    public var canTime : Int = 20 {
        willSet(newTime) {
            canadianPicker.time = newTime
        }
    }
    public var numTurns : Int = 5 {
        willSet(newNumTurns) {
            canadianPicker.numTurns = newNumTurns
        }
    }

    override var phases: [Phase] {
        let aPhase = AbsolutePhase(time: mainTime)
        let bPhase = CanadianPhase(time: canTime, numTurns: numTurns)
        return [aPhase, bPhase]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hmsPicker.translatesAutoresizingMaskIntoConstraints = false
        hmsPicker.hmsDelegate = self
        hmsPicker.time = mainTime
        canadianPicker.translatesAutoresizingMaskIntoConstraints = false
        canadianPicker.canadianDelegate = self
        canadianPicker.time = canTime
        canadianPicker.numTurns = numTurns
    }

    func timeSelected(seconds: Int) {
        mainTime = seconds
    }

    func timeSelected(time: Int, numTurns: Int) {
        canTime = time
        self.numTurns = numTurns
    }



}
