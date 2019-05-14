//
//  MainViewController.swift
//  WorkTimer
//
//  Created by Grzesiek Kulesza on 09/04/2019.
//  Copyright © 2019 Grzesiek Kulesza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var cardsCollection: [UIButton]!
    @IBOutlet var numbersOnCards: [UILabel]!
    
    var myWorkingData = workingData()
    var actualDateCount: Date?
    
    var digitsValuesOnCards = Array(repeating: 0, count: 13)
    var actualCardActive: Int = 13
    
    @IBOutlet weak var bonusImageView: UIImageView!
    
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
            myWorkingData.cardTimeSec[i] = 0
        }
        summaryTupple = ["","",""]
        myWorkingData.startTime = nil
        actualCardActive = 13
        setDefaultBackgroundCards()
        setNumbersOnCards()
    }
    
    @IBAction func cardsButtonPressed(_ sender: UIButton) {
        
        // make start date (works on first start)
        if (myWorkingData.startTime == nil) && (actualCardActive == 13) {
            myWorkingData.startTime = Date()
            actualDateCount = Date()
            actualCardActive = sender.tag
        }
        
        let TimeToAdd = actualDateCount!.timeIntervalSinceNow * -1
        addTimeToEvent(buttonNr: actualCardActive, value: Int(TimeToAdd))
        actualDateCount = Date()
        actualCardActive = sender.tag
        
        for card in cardsCollection {
            if card.tag == sender.tag {
                let imageBackName = "cardImage\(sender.tag)"
                setDefaultBackgroundCards()
                card.setImage(UIImage(named: imageBackName), for: .normal)
                digitsValuesOnCards[sender.tag] += 1
            }
            for label in numbersOnCards {
                if sender.tag == label.tag {
                    label.text = String(digitsValuesOnCards[label.tag])
                }
            }
        }
    }
    
    // info : Show all cards on tap
    @IBAction func infoButtonTouched(_ sender: UIButton) {
        for card in cardsCollection {
                let imageBackName = "cardImage\(card.tag)"
                card.setImage(UIImage(named: imageBackName), for: .normal)
                card.alpha = 0.5
        }
    }
    // info : Hide all cards on relase (only active is stay) 
    @IBAction func infoButtonReleased(_ sender: UIButton) {
        setDefaultBackgroundCards()
        
        for card in cardsCollection {
            card.alpha = 1
            if card.tag == actualCardActive {
                let imageBackName = "cardImage\(card.tag)"
                card.setImage(UIImage(named: imageBackName), for: .normal)
            }
        }
        
        //show bonus image if conditions are met
        bonusImageView.isHidden = true
        if digitsValuesOnCards == [0, 6, 0, 0, 6, 0, 0, 6, 0, 0, 6, 0, 0] {
        bonusImageView.isHidden = false
        }
        print(digitsValuesOnCards)
    }
    
    func setDefaultBackgroundCards() {
        for card in cardsCollection {
            card.setImage(#imageLiteral(resourceName: "BackCard"), for: .normal)
            if card.tag == 0 {
                card.setImage(#imageLiteral(resourceName: "BackCard_dark"), for: .normal)
            }
        }
    }
    
    func setNumbersOnCards() {
        for label in numbersOnCards {
            label.text = String(digitsValuesOnCards[label.tag])
        }
    }
    
    func addTimeToEvent(buttonNr: Int, value: Int) {
        
        myWorkingData.cardTimeSec[buttonNr] += value
        
    }
    
    @IBAction func summaryButtonPressed(_ sender: Any) {
        
        if actualCardActive != 13 {
            setTimesTupple()
            setSummaryTupple()
            presentDetail(SummaryViewController.init())
        }
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
        return ("\(actualHours)h \(actualMinutes)m")
    }
    
    func setSummaryTupple(){
        
        summaryTupple[0] = stringDataFromDate(theDate: myWorkingData.startTime)// start work time
        summaryTupple[1] = stringDataFromDate(theDate: myWorkingData.startTime, addSec: 8 * 60 * 60)
        
        myWorkingData.summaryTime = myWorkingData.cardTimeSec[0]
        for i in 7...12 {
          myWorkingData.summaryTime += myWorkingData.cardTimeSec[i]
        }
        
        summaryTupple[2] = secondsToHoursMinutesSeconds(seconds: myWorkingData.summaryTime)
    }
    
    func setTimesTupple(){
        for i in 0...12 {
        timesTupple[i] = secondsToHoursMinutesSeconds(seconds: myWorkingData.cardTimeSec[i])
        }
    }
    
}


// move to next (result) screen from right
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
