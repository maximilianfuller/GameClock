//
//  DetailViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/13/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

class DetailViewController : UITableViewController {
    var phases : [Phase] {
        return []
    }
    var index : Int = 0
}

/*
 adapted from
 https://github.com/luismachado/Swift/blob/master/PickerLabels.swift
 */
extension UIPickerView {
    func setPickerLabels(labels: [Int:String]) {
        let xOffset : CGFloat = 15
        let fontSize:CGFloat = 16
        let labelWidth:CGFloat = self.frame.width / CGFloat(self.numberOfComponents)
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
        for i in 0..<self.numberOfComponents {
            if let str = labels[i] {
                let label = UILabel()
                label.text = str
                label.textColor = UIColor.white
                label.frame = CGRect(x: labelWidth * (CGFloat(i)+0.5) + xOffset, y: y, width: 0.5*labelWidth, height: fontSize)
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.backgroundColor = .clear
                label.textAlignment = .left
                self.addSubview(label)
            }
        }
    }
}
