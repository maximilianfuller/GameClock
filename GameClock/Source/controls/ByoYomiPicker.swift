//
//  ByoYomiPicker.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/14/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

protocol BYPickerDelegate {
    func timeSelected(time: Int, numPeriods: Int)
}

class ByoYomiPicker : UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    public var time : Int  {
        get  {
            return selectedRow(inComponent: 1)
        }
        set {
            selectRow(newValue, inComponent: 1, animated: false)
        }
    }
    public var numPeriods : Int  {
        get  {
            return selectedRow(inComponent: 0)
        }
        set {
            selectRow(newValue, inComponent: 0, animated: false)
        }
    }

    public var byDelegate : BYPickerDelegate? = nil

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
        setPickerLabels(labels: [0:"periods", 1: "sec"])
        super.layoutSubviews()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0:
            return 100
        case 1:
            return 60
        default:
            return 10
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }

        label.textColor = UIColor.white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = String(row)

        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        byDelegate?.timeSelected(time: time, numPeriods: numPeriods)
    }
}
