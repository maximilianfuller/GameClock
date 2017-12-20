//
//  AbsolutePhaseClock.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/29/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

class AbsolutePhaseClock : PhaseClock {

    func endTurn() { }

    private var time : Double

    init(phase: AbsolutePhase) {
        self.time = Double(phase.time)
    }
    
    func tick(timeElapsed: Double) {
        time -= timeElapsed
        time = max(time, 0.0)
    }

    func isDone() -> Bool {
        return time == 0.0
    }

    func getTime() -> Double {
        return time
    }

    func getSecondaryValue() -> String? {
        return nil
    }
}
