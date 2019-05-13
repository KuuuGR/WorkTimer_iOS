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
    @IBOutlet var cardsCollection: [UIButton]!
    @IBOutlet var numbersOnCards: [UILabel]!
    
    
    
    
    var myWorkingData = workingData()
    var actualDateCount: Date?
    var actualButtonPressed: Int = 0
    
    var digitsValuesOnCards = Array(repeating: 0, count: 13)
    var actualCardActive: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumbersOnCards()
       
    }

    deinit {
        cardsCollection.removeAll()
        numbersOnCards.removeAll()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        for i in 0..<13 {
            digitsValuesOnCards[i] = 0
        }
        setDefaultBackgroundCards()
        setNumbersOnCards()
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
    
    @IBAction func cardsButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        actualCardActive = sender.tag
        for card in cardsCollection {
            if card.tag == sender.tag {
                let imageBackName = "cardImage\(sender.tag)"
                setDefaultBackgroundCards()
                card.setImage(UIImage(named: imageBackName), for: .normal)
                digitsValuesOnCards[sender.tag - 1] += 1
            }
            for label in numbersOnCards {
                if sender.tag == label.tag {
                    label.text = String(digitsValuesOnCards[label.tag - 1])
                }
            }
        }
    }
    
    // info : Show all cards on tap
    @IBAction func infoButtonTouched(_ sender: UIButton) {
        print("Preston")
        for card in cardsCollection {
                let imageBackName = "cardImage\(card.tag)"
                card.setImage(UIImage(named: imageBackName), for: .normal)
                card.alpha = 0.5
        }
        
    }
    // info : Hide all cards on relase (only active is stay) 
    @IBAction func infoButtonReleased(_ sender: UIButton) {
        print("Unpreston")
        setDefaultBackgroundCards()
        
        for card in cardsCollection {
            card.alpha = 1
            if card.tag == actualCardActive {
                let imageBackName = "cardImage\(card.tag)"
                card.setImage(UIImage(named: imageBackName), for: .normal)
            }
        }
        
    }
    
    
    
    
    func setDefaultBackgroundCards(){
        for card in cardsCollection {
            card.setImage(#imageLiteral(resourceName: "BackCard"), for: .normal)
        }
    }
    
    func setNumbersOnCards(){
        for label in numbersOnCards {
            label.text = String(digitsValuesOnCards[label.tag - 1])
        }
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
        return ("\(actualHours) h \(actualMinutes) m \(actualSeconds) s")
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
