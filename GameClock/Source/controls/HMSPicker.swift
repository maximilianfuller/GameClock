//
//  HMSPicker.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/5/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

protocol HMSPickerDelegate {
    func timeSelected(seconds: Int)
}

class HMSPicker : UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    public var time : Int  {
        get  {
            let hours = selectedRow(inComponent: 0)
            let minutes = selectedRow(inComponent: 1)
            let seconds = selectedRow(inComponent: 2)
            return  hours*3600 + minutes*60 + seconds
        }
        set {
            selectRow(newValue/3600, inComponent: 0, animated: false)
            selectRow((newValue%3600)/60, inComponent: 1, animated: false)
            selectRow(newValue%60, inComponent: 2, animated: false)
        }
    }

    public var hmsDelegate : HMSPickerDelegate? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect())
    }

    override func layoutSubviews() {
        self.subviews.forEach({ ($0 as? UILabel)?.removeFromSuperview() })
        setPickerLabels(labels: [0:"hours", 1: "min", 2: "sec"])
        super.layoutSubviews()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0:
            return 10
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = String(row)

        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hmsDelegate?.timeSelected(seconds: time)
    }

}
