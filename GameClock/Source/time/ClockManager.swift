//
//  Timer.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/28/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class ClockManager {

    //private data
    private var prevTimeStamp: Double = 0
    private var p1PhaseIndex: Int = 0
    private var p2PhaseIndex: Int = 0
    private var p1PhaseClocks: [PhaseClock] = []
    private var p2PhaseClocks: [PhaseClock] = []

    //public settings
    var isPlayer1Turn : Bool = true {
        willSet(newIsPlayer1Turn) {
            if isPlayer1Turn == newIsPlayer1Turn || isP1Lost || isP2Lost { return }
            if isPlayer1Turn {
                p1PhaseClocks[p1PhaseIndex].endTurn()
            } else {
                p2PhaseClocks[p2PhaseIndex].endTurn()
            }
        }
    }

    let phases: [Phase]
    var isPaused : Bool = true

    //public computed properties
    var isP1Lost : Bool { return p1PhaseIndex >= phases.count }
    var isP2Lost : Bool { return p2PhaseIndex >= phases.count }
    var p1Time : String {
        return isP1Lost ? "0.0" : Utils.timeToString(p1PhaseClocks[p1PhaseIndex].getTime())
    }
    var p2Time : String {
        return isP2Lost ? "0.0" : Utils.timeToString(p2PhaseClocks[p2PhaseIndex].getTime())
    }
    var p1SecondaryValue : String? {
        return isP1Lost ? p1PhaseClocks.last?.getSecondaryValue() : p1PhaseClocks[p1PhaseIndex].getSecondaryValue()
    }
    var p2SecondaryValue : String? {
        return isP2Lost ? p2PhaseClocks.last?.getSecondaryValue() : p2PhaseClocks[p2PhaseIndex].getSecondaryValue()
    }
    var p1Color : UIColor {
        return isP1Lost ? Utils.RED : phases[p1PhaseIndex].color
    }
    var p2Color : UIColor {
        return isP2Lost ? Utils.RED : phases[p2PhaseIndex].color
    }

    init(phases: [Phase]) {
        self.phases = phases
        initPhaseClocks()
    }

    func initPhaseClocks() {
        p1PhaseClocks.removeAll()
        p2PhaseClocks.removeAll()
        for phase in self.phases {
            if let absolutePhase = phase as? AbsolutePhase {
                p1PhaseClocks.append(AbsolutePhaseClock(phase: absolutePhase))
                p2PhaseClocks.append(AbsolutePhaseClock(phase: absolutePhase))
            } else if let byoYomiPhase = phase as? ByoYomiPhase {
                p1PhaseClocks.append(ByoYomiPhaseClock(phase: byoYomiPhase))
                p2PhaseClocks.append(ByoYomiPhaseClock(phase: byoYomiPhase))
            } else if let incrementPhase = phase as? IncrementPhase {
                p1PhaseClocks.append(IncrementPhaseClock(phase: incrementPhase))
                p2PhaseClocks.append(IncrementPhaseClock(phase: incrementPhase))
            } else if let canadianPhase = phase as? CanadianPhase {
                p1PhaseClocks.append(CanadianPhaseClock(phase: canadianPhase))
                p2PhaseClocks.append(CanadianPhaseClock(phase: canadianPhase))
            }
        }
    }

    func update() {
        let currentTimeStamp = CACurrentMediaTime()
        if(prevTimeStamp != 0) {
            tick(timeElapsed: currentTimeStamp-prevTimeStamp)
        }
        prevTimeStamp = currentTimeStamp
    }

    private func tick(timeElapsed: Double) {
        if isPaused || isP1Lost || isP2Lost { return }
        if isPlayer1Turn {
            p1PhaseClocks[p1PhaseIndex].tick(timeElapsed: timeElapsed)
        } else {
            p2PhaseClocks[p2PhaseIndex].tick(timeElapsed: timeElapsed)
        }
        if p1PhaseClocks[p1PhaseIndex].isDone() { p1PhaseIndex += 1 }
        if p2PhaseClocks[p2PhaseIndex].isDone() { p2PhaseIndex += 1 }
    }

    func restart() {
        p1PhaseIndex = 0
        p2PhaseIndex = 0
        isPaused = true
        initPhaseClocks()
    }

}
