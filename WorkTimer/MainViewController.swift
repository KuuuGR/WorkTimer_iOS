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
    
    var currentSelectButton: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentSelectButton)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func drinkButtonPressed(_ sender: Any) {
        currentSelectButton = 1
        onlyOneButtonMarked(drinkButton)
    }
    
    @IBAction func jobButtonPressed(_ sender: Any) {
        currentSelectButton = 2
        onlyOneButtonMarked(jobButton)
    }
    
    @IBAction func eatButtonPressed(_ sender: Any) {
        currentSelectButton = 3
        onlyOneButtonMarked(eatButton)
    }
    
    
    func onlyOneButtonMarked(_ Button: UIButton) {
        print(currentSelectButton)
        drinkButton.alpha = 0.2
        jobButton.alpha = 0.2
        eatButton.alpha = 0.2
        Button.alpha = 1
    }

    @IBAction func summaryButtonPressed(_ sender: Any) {
        presentDetail(SummaryViewController.init())
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
