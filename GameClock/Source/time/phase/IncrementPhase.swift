//
//  IncrementPhase.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/26/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation
import UIKit

class IncrementPhase : Phase {
    public let time : Int //seconds
    public let increment : Int // seconds

    init(time : Int, increment : Int) {
        self.time = time
        self.increment = increment
    }

    var color: UIColor {
        get {
            return Utils.BLUE
        }
    }
}
