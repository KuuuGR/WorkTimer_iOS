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
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    
    @IBAction func drinkButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(drinkButton)
    }
    
    @IBAction func jobButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(jobButton)
    }
    
    @IBAction func eatButtonPressed(_ sender: Any) {
        onlyOneButtonMarked(eatButton)
    }
    
    
    func onlyOneButtonMarked(_ button: UIButton) {
        
        if (myWorkingData.startTime == nil) {
            myWorkingData.startTime = Date()
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
    
    
    func actualDate() -> String{
        guard let timeCountStartingPoint = myWorkingData.startTime else { return "none" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: timeCountStartingPoint)
        return result
    }
    
    func setSummaryTupple(){
        
        summaryTupple[0] = "must set"
        summaryTupple[1] = "must set"
        summaryTupple[2] = "must set"
        summaryTupple[3] = "must set"
        summaryTupple[4] = "must set"
        summaryTupple[5] = "must set"
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
