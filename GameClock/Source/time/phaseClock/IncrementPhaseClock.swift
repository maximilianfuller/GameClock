//
//  IncrementPhaseClock.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/26/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

class IncrementPhaseClock : PhaseClock {

    private var time : Double
    private let increment : Int

    init(phase: IncrementPhase) {
        self.time = Double(phase.time)
        self.increment = phase.increment
    }

    func tick(timeElapsed: Double) {
        time -= timeElapsed
        time = max(time, 0.0)
    }

    func endTurn() {
        time += Double(increment)
    }

    func isDone() -> Bool {
        return time <= 0.0
    }

    func getTime() -> Double {
        return time
    }

    func getSecondaryValue() -> String? {
        return nil
    }
}
