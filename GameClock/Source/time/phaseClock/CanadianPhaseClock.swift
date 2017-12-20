//
//  CanadianPhaseClock.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/26/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

class CanadianPhaseClock : PhaseClock {

    private let totalTime : Double
    private let numTurns: Int

    private var timeLeft: Double
    private var turnsLeft: Int

    init(phase: CanadianPhase) {
        self.totalTime = Double(phase.time)
        self.timeLeft = self.totalTime
        self.numTurns = phase.numTurns
        self.turnsLeft = self.numTurns
    }

    func tick(timeElapsed: Double) {
        timeLeft -= timeElapsed
        timeLeft = max(timeLeft, 0.0)
    }

    func endTurn() {
        turnsLeft -= 1
        if turnsLeft == 0 {
            turnsLeft = numTurns
            timeLeft = totalTime
        }
    }

    func isDone() -> Bool {
        return timeLeft <= 0.0
    }

    func getTime() -> Double {
        return timeLeft
    }

    func getSecondaryValue() -> String? {
        return String(describing: turnsLeft) + " turn" + (turnsLeft == 1 ? "" : "s")
    }
}
