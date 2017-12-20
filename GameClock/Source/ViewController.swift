//
//  ViewController.swift
//  GameClock
//
//  Created by Maximilian Fuller on 10/28/17.
//  Copyright © 2017 maximilianfuller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var clock : ClockManager! = nil
    private var prevTimeStamp : Float = 0
    private var linkPaused = false

    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!

    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!

    @IBOutlet weak var topSecondaryLabel: UILabel!
    @IBOutlet weak var bottomSecondaryLabel: UILabel!

    @IBOutlet weak var pauseToMenuSpacing: NSLayoutConstraint!
    @IBOutlet weak var restartToPauseSpacing: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let link = CADisplayLink(target: self, selector: #selector(step))
        link.add(to: .current, forMode: .defaultRunLoopMode)
        clock = ClockManager(phases: [AbsolutePhase(time:300)])
        setupView()
        hidePauseButton()
    }

    @objc func step(displaylink: CADisplayLink) {
        if linkPaused { return }
        clock.update()
        updateView()
        if clock.isP1Lost || clock.isP2Lost {
            hidePauseButton()
        }
    }

    @IBAction func onTopPressed(_ sender: Any) {
        if clock.isP1Lost || clock.isP2Lost {
            return
        }
        clock.isPaused = false
        clock.isPlayer1Turn = false
        unhidePauseButton()
    }

    @IBAction func onBottomPressed(_ sender: Any) {
        if clock.isP1Lost || clock.isP2Lost {
            return
        }
        clock.isPaused = false
        clock.isPlayer1Turn = true
        unhidePauseButton()
    }

    @IBAction func onRestartPressed(_ sender: Any) {
        clock.isPaused = true
        let alert = UIAlertController()
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let restartAction = UIAlertAction(title: "Reset", style: UIAlertActionStyle.destructive, handler: {
            (action: UIAlertAction) -> Void in
            self.clock.restart()
            self.updateView()
            self.hidePauseButton()
        })
        alert.addAction(restartAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func onPausePressed(_ sender: Any) {
        clock.isPaused = true
        hidePauseButton()
    }

    func setupView() {
        self.view.backgroundColor = UIColor.black

        topButton.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 90, weight: .thin)
        bottomButton.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 90, weight: .thin)
        topButton.setTitleColor(UIColor.white, for: .normal)
        bottomButton.setTitleColor(UIColor.white, for: .normal)

        topSecondaryLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .ultraLight)
        bottomSecondaryLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .ultraLight)
        topSecondaryLabel.textColor = UIColor.white
        bottomSecondaryLabel.textColor = UIColor.white

        let pauseImage = UIImage(named: "pause.png")
        let tintedPauseImage = pauseImage?.withRenderingMode(.alwaysTemplate)
        pauseButton.setImage(tintedPauseImage, for: .normal)
        pauseButton.tintColor = UIColor.white

        let restartImage = UIImage(named: "restart.png")
        let tintedRestartImage = restartImage?.withRenderingMode(.alwaysTemplate)
        restartButton.setImage(tintedRestartImage, for: .normal)
        restartButton.tintColor = UIColor.white

        let menuImage = UIImage(named: "menu.png")
        let tintedMenuImage = menuImage?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(tintedMenuImage, for: .normal)
        menuButton.tintColor = UIColor.white

        topButton.layer.transform = CATransform3DMakeRotation(.pi, 0.0, 0.0, 1.0);
        topSecondaryLabel.layer.transform = CATransform3DMakeRotation(.pi, 0.0, 0.0, 1.0);
        pauseButton.isHidden = true
        pauseButton.alpha = 0
    }

    func updateView() {
        topButton.setTitle(clock.p1Time, for: .normal)
        bottomButton.setTitle(clock.p2Time, for: .normal)
        topSecondaryLabel.text = clock.p1SecondaryValue ?? ""
        bottomSecondaryLabel.text = clock.p2SecondaryValue ?? ""

        topButton.backgroundColor = UIColor.black
        bottomButton.backgroundColor = UIColor.black

        if clock.isP1Lost {
            topButton.setTitleColor(UIColor.white, for: .normal)
            topButton.backgroundColor = Utils.RED
        } else if clock.isP2Lost {
            bottomButton.setTitleColor(UIColor.white, for: .normal)
            bottomButton.backgroundColor = Utils.RED
        } else if !clock.isPaused {
            if clock.isPlayer1Turn {
                topButton.setTitleColor(UIColor.white, for: .normal)
                topButton.backgroundColor = clock.p1Color
            } else {
                bottomButton.setTitleColor(UIColor.white, for: .normal)
                bottomButton.backgroundColor = clock.p2Color
            }
        }
    }

    func hidePauseButton() {
        if pauseButton.isHidden {
            return
        }
        self.restartToPauseSpacing.constant = 0
        self.pauseToMenuSpacing.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.pauseButton.alpha = 0
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.pauseButton.isHidden = true
        }
    }

    func unhidePauseButton() {
        if !pauseButton.isHidden {
            return
        }
        self.restartToPauseSpacing.constant = 40
        self.pauseToMenuSpacing.constant = 40
        self.pauseButton.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.pauseButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        clock.isPaused = true
        hidePauseButton()
        linkPaused = true
        let settings = segue.destination as! SettingsViewController
        if let inc = clock.phases.last! as? IncrementPhase {
            settings.initialIndex = 0
            settings.mainTime = inc.time
            settings.increment = inc.increment
        } else if let byoyomi = clock.phases.last! as? ByoYomiPhase {
            settings.initialIndex = 1
            settings.mainTime = (clock.phases.first! as! AbsolutePhase).time
            settings.byoYomiPeriods = byoyomi.numPeriods
            settings.byoYomiTime = byoyomi.time
        } else if let canadian = clock.phases.last! as? CanadianPhase {
            settings.initialIndex = 2
            settings.mainTime = (clock.phases.first! as! AbsolutePhase).time
            settings.canadianTime = canadian.time
            settings.canadianTurns = canadian.numTurns
        } else if let abs = clock.phases.last! as? AbsolutePhase {
            settings.initialIndex = 0
            settings.mainTime = abs.time
        }
    }

    @IBAction func unwindFromSettings(segue: UIStoryboardSegue) {
        linkPaused = false
        let settingsVC = segue.source as! SettingsViewController
        if(segue.identifier != "back") {
            clock = ClockManager(phases: settingsVC.phases)
        }
        setupView()
        hidePauseButton()

    }
}

