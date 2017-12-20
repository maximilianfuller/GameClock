//
//  DetailContainerViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 12/8/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import Foundation
import UIKit

class DetailContainerViewController : UIViewController {

    var detailViewController : DetailViewController!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        detailViewController = segue.destination as! DetailViewController
    }
}
