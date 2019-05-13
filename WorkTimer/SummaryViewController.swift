//
//  SummaryViewController.swift
//  WorkTimer
//
//  Created by Grzesiek Kulesza on 09/04/2019.
//  Copyright © 2019 Grzesiek Kulesza. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var workStartLabel: UILabel!
    @IBOutlet weak var workEndLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var eatLabel: UILabel!
    @IBOutlet weak var logTimeLabel: UILabel!
    
    @IBOutlet var resultTimeLabels: [UILabel]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        workStartLabel.text = summaryTupple[0]
        workEndLabel.text = summaryTupple[1]
        logTimeLabel.text = summaryTupple[2]
        
        for label in resultTimeLabels {
            label.text = timesTupple[label.tag]
        }
        
        // show red color warning if the time to log in less then 6 hours
        guard summaryTupple[2] != "" else {
            return logTimeLabel.text = "back & tap the card"
        }
            let newstr = summaryTupple[2]
            var token = newstr.components(separatedBy: ["h", "m", "s"])
        
            logTimeLabel.text = ("\(token[0])h \(token[1])m")
        
            if (Int(token[0]) ?? 0) < 6 {
                logTimeLabel.textColor = UIColor(red: 181/255, green: 64/255, blue: 44/255, alpha: 1.00)
            } else {
                logTimeLabel.textColor = UIColor(red: 60/255, green: 178/255, blue: 226/255, alpha: 1.00)
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func BackButtonAction(_ sender: Any) {
        dismissDetail()
    }
    
}
