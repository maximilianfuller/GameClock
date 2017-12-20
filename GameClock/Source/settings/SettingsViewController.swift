//
//  SettingsViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 11/2/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

class SettingsViewController : UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var initialIndex : Int = 0
    var phases : [Phase] {
        guard let container = pvc.viewControllers?.first as? DetailContainerViewController else {
            return []
        }
        return container.detailViewController.phases
    }

    public var mainTime : Int = 300
    public var increment : Int = 0
    public var byoYomiTime : Int = 10 //secs
    public var byoYomiPeriods : Int = 5
    public var canadianTime : Int = 300
    public var canadianTurns : Int = 10


    private let NUM_PAGES = 3
    private var pvc : UIPageViewController! = nil
    private var pages : [Int: DetailContainerViewController] = [:]

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        pvc = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        pvc.dataSource = self
        pvc.delegate = self

        //initialize all view controllers

        var pageVCs : [DetailContainerViewController] = []
        for i in 0..<NUM_PAGES {
            pageVCs.append(getViewControllerForIndex(index: i)!)
        }

        pvc.setViewControllers([pageVCs[initialIndex]], direction: .forward, animated: true, completion: nil)
        pvc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)

        addChildViewController(pvc)
        contentView.addSubview(pvc.view)
        pvc.didMove(toParentViewController: self)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let container = viewController as! DetailContainerViewController
        return getViewControllerForIndex(index: container.detailViewController.index-1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let container = viewController as! DetailContainerViewController
        return getViewControllerForIndex(index: container.detailViewController.index+1)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return NUM_PAGES
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return initialIndex
    }

    func getViewControllerForIndex(index: Int) -> DetailContainerViewController? {
        if let vc = pages[index] {
            return vc
        }
        var container : DetailContainerViewController!
        switch(index) {
        case 0:
            container = self.storyboard?.instantiateViewController(withIdentifier: "AbsoluteContainerController") as? DetailContainerViewController
            container.loadViewIfNeeded()
            (container.detailViewController as! AbsoluteDetailViewController).time = mainTime
            (container.detailViewController as! AbsoluteDetailViewController).increment = increment
            break;
        case 1:
            container = self.storyboard?.instantiateViewController(withIdentifier: "ByoYomiContainerController") as? DetailContainerViewController
            container.loadViewIfNeeded()
            (container.detailViewController as! ByoYomiDetailViewController).mainTime = mainTime
            (container.detailViewController as! ByoYomiDetailViewController).byoYomiTime = byoYomiTime
            (container.detailViewController as! ByoYomiDetailViewController).numPeriods = byoYomiPeriods
            break;
        case 2:
            container = self.storyboard?.instantiateViewController(withIdentifier: "CanadianContainerController") as? DetailContainerViewController
            container.loadViewIfNeeded()
            (container.detailViewController as! CanadianDetailViewController).mainTime = mainTime
            (container.detailViewController as! CanadianDetailViewController).canTime = canadianTime
            (container.detailViewController as! CanadianDetailViewController).numTurns = canadianTurns
            break;
        default:
            return nil
        }
        container.detailViewController.index = index
        pages[index] = container
        return container
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
