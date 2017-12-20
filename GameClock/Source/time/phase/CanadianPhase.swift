//
//  CanadianPhase.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/26/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation
import UIKit

class CanadianPhase : Phase {
    public let time : Int //seconds
    public let numTurns : Int // seconds

    init(time : Int, numTurns : Int) {
        self.time = time
        self.numTurns = numTurns
    }

    var color: UIColor {
        get {
            return Utils.ORANGE
        }
    }
}
