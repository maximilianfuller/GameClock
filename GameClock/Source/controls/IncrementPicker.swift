//
//  HMSPicker.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/5/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

protocol IncrementPickerDelegate {
    func timeSelected(increment: Int)
}

class IncrementPicker : UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    public var time : Int  {
        get  {
            return selectedRow(inComponent: 0)+1
        }
        set {
            selectRow(newValue-1, inComponent: 0, animated: false)
        }
    }

    public var incrementDelegate : IncrementPickerDelegate? = nil

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
        setPickerLabels(labels: [0:"sec"])
        super.layoutSubviews()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }

        label.textColor = UIColor.white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = String(row+1)

        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        incrementDelegate?.timeSelected(increment: row+1)
    }
}

