//
//  AbsolutePhase.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/29/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation
import UIKit

class AbsolutePhase : Phase {
    public let time : Int //in seconds

    init(time : Int) {
        self.time = time
    }

    var color: UIColor {
        get {
            return Utils.GREEN
        }
    }
}
