//
//  MainViewController.swift
//  WorkTimer
//
//  Created by Grzesiek Kulesza on 09/04/2019.
//  Copyright © 2019 Grzesiek Kulesza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var jobButton: UIButton!
    @IBOutlet weak var eatButton: UIButton!
    
    var myWorkingData = workingData()
    var actualDateCount: Date?
    var actualButtonPressed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    @IBAction func drinkButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(drinkButton)
        let TimeToAdd = actualDateCount!.timeIntervalSinceNow * -1
        addTimeToEvent(buttonNr: actualButtonPressed, value: Int(TimeToAdd))
        actualDateCount = Date()
        actualButtonPressed = 1
    }
    
    @IBAction func jobButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(jobButton)
        let TimeToAdd = actualDateCount!.timeIntervalSinceNow * -1
        addTimeToEvent(buttonNr: actualButtonPressed, value: Int(TimeToAdd))
        actualDateCount = Date()
        actualButtonPressed = 2
    }
    
    @IBAction func eatButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(eatButton)
        let TimeToAdd = actualDateCount!.timeIntervalSinceNow * -1
        addTimeToEvent(buttonNr: actualButtonPressed, value: Int(TimeToAdd))
        actualDateCount = Date()
        actualButtonPressed = 3
    }
    
    
    
    
    func addTimeToEvent(buttonNr: Int, value: Int) {
        
        switch buttonNr {
        case 1:
            myWorkingData.coffeTimeSec += value
        case 2:
            myWorkingData.workTimeSec += value
        case 3:
            myWorkingData.eatTimeSec += value
        default:
            return
        }
    }
    
    func onlyOneButtonMarked(_ button: UIButton) {
        
        if (myWorkingData.startTime == nil) && (actualButtonPressed == 0) {
            myWorkingData.startTime = Date()
            actualDateCount = Date()
        }
        drinkButton.alpha = 0.2
        jobButton.alpha = 0.2
        eatButton.alpha = 0.2
        button.alpha = 1
    }

    @IBAction func summaryButtonPressed(_ sender: Any) {
        
        setSummaryTupple()
        presentDetail(SummaryViewController.init())
    }
    
    func stringDataFromDate(theDate: Date?, addSec: Int = 0) -> String {
        guard let timeCountStartingPoint = theDate?.addingTimeInterval(TimeInterval(addSec)) else { return "none" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"//"dd.MM.yyyy""HH:mm:ss.SSS"
        let result = formatter.string(from: timeCountStartingPoint)
        return result
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> String {
        let actualHours = seconds / 3600
        let actualMinutes = (seconds % 3600) / 60
        let actualSeconds = (seconds % 3600) % 60
        return ("\(actualHours) Hours \(actualMinutes) Minutes \(actualSeconds) Seconds")
    }
    
    func secondsToHoursMinutes(seconds: Int) -> String {
        let actualHours = seconds / 3600
        let actualMinutes = (seconds % 3600) / 60
        return ("\(actualHours)H \(actualMinutes)m")
    }
    
    
    func setSummaryTupple(){
        
        summaryTupple[0] = stringDataFromDate(theDate: myWorkingData.startTime)// start work time
        summaryTupple[1] = stringDataFromDate(theDate: myWorkingData.startTime, addSec: 8 * 60 * 60)
        summaryTupple[2] = secondsToHoursMinutesSeconds(seconds: Int(myWorkingData.workTimeSec)) // current Job time
        summaryTupple[3] = secondsToHoursMinutesSeconds(seconds: Int(myWorkingData.coffeTimeSec))// current drik time
        summaryTupple[4] = secondsToHoursMinutesSeconds(seconds: Int(myWorkingData.eatTimeSec)) // current eat time
        summaryTupple[5] = secondsToHoursMinutes(seconds: Int(myWorkingData.workTimeSec)) // time to login at work
    }
    
}


extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}
