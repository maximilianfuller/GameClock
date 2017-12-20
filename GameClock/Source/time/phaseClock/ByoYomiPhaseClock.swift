//
//  ByoYomiPhaseClock.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/29/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

class ByoYomiPhaseClock : PhaseClock {

    private var timePerPeriod : Double
    private var periodsRemaining : Int
    private var time : Double

    init(phase: ByoYomiPhase) {
        self.timePerPeriod = Double(phase.time)
        self.periodsRemaining = phase.numPeriods
        self.time = timePerPeriod
    }

    func tick(timeElapsed: Double) {
        time -= timeElapsed
        if time <= 0.0 {
            time = timePerPeriod
            periodsRemaining -= 1
        }
        if periodsRemaining <= -1 {
            time = 0.0
        }
    }

    func endTurn() {
        time = timePerPeriod
    }

    func isDone() -> Bool {
        return periodsRemaining <= 0
    }

    func getTime() -> Double {
        return time
    }

    func getSecondaryValue() -> String? {
        return String(describing: periodsRemaining) + " period" + (periodsRemaining == 1 ? "" : "s")
    }
}
