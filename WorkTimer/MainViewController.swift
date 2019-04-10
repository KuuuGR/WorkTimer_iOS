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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }

    
    @IBAction func drinkButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(drinkButton)
        actualDateCount = Date()
    }
    
    @IBAction func jobButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(jobButton)
        actualDateCount = Date()
    }
    
    @IBAction func eatButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(eatButton)
        actualDateCount = Date()
    }
    
    
    func onlyOneButtonMarked(_ button: UIButton) {
        
        if (myWorkingData.startTime == nil) {
            myWorkingData.startTime = Date()
            actualDateCount = Date()
        }
        print(String(button.accessibilityIdentifier ?? "0"))
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
    
//    func intervalBetweenDates(myDate: Date?) -> String {
//        guard let difference = String(myDate?.timeIntervalSinceNow * -1 ?? 0) else { return "error"}
//        return difference
//    }
    
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
        
        let totalTime: Int = Int(myWorkingData.workTimeSec) + Int(myWorkingData.coffeTimeSec) + Int(myWorkingData.eatTimeSec)
        summaryTupple[5] = secondsToHoursMinutes(seconds: totalTime) // time to login at work
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
