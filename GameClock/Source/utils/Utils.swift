//
//  Utils.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/29/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

class Utils {

    private static var formatter = NumberFormatter()

    static func timeToString(_ time : Double) -> String {
        let hours = Int(time/3600)
        let minutes = Int(fmod(time, 3600.0)/60)
        let seconds = fmod(time, 60.0)

        formatter.maximumFractionDigits = time >= 10.0 ? 0 : 1
        formatter.minimumFractionDigits = time >= 10.0 ? 0 : 1
        formatter.minimumIntegerDigits = 2
        formatter.roundingMode = .down
        let secString = formatter.string(from: seconds as NSNumber)!
        formatter.minimumFractionDigits = 0
        formatter.minimumIntegerDigits = time >= 600.0 ? 2 : 1
        let minString = formatter.string(from: minutes as NSNumber)!
        var out = "\(minString):\(secString)"
        if hours > 0 {
            out = "\(hours):"+out
        }
        return out
    }

    static let GREEN = UIColor(red: 89/255.0, green: 192/255.0, blue: 124/255.0, alpha: 1.0)
    static let LIGHT_GRAY = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
    static let DARK_GRAY = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    static let RED = UIColor(red: 180/255.0, green: 0/255.0, blue: 30/255.0, alpha: 1.0)
    static let PURPLE = UIColor(red: 138/255.0, green: 43/255.0, blue: 226/255.0, alpha: 1.0)
    static let BLUE = UIColor(red: 40/255.0, green: 20/255.0, blue: 226/255.0, alpha: 1.0)
    static let ORANGE = UIColor(red: 255/255.0, green: 153/255.0, blue: 102/255.0, alpha: 1.0)
}
