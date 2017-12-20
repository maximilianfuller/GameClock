//
//  ByoYomiPhase.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/29/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation
import UIKit

class ByoYomiPhase : Phase {
    public let time : Int //in seconds
    public let numPeriods : Int

    init(time: Int, numPeriods: Int) {
        self.time = time
        self.numPeriods = numPeriods
    }

    var color: UIColor {
        get {
            return Utils.PURPLE
        }
    }
}
