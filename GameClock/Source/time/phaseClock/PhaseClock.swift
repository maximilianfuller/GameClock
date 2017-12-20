//
//  PhaseClock.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/29/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation

//initiates and updates a phase for a single player
protocol PhaseClock {
    func tick(timeElapsed: Double)
    func endTurn()
    func isDone() -> Bool
    func getTime() -> Double
    func getSecondaryValue() -> String? //e.g. byo yomi/canadians turns per period
}
