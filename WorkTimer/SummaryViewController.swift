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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        workStartLabel.text = summaryTupple[0]
        workEndLabel.text = summaryTupple[1]
        jobLabel.text = summaryTupple[2]
        drinkLabel.text = summaryTupple[3]
        eatLabel.text = summaryTupple[4]
        logTimeLabel.text = summaryTupple[5]
        
        // show red color warning if the time to log in less then 6 hours
        let delimiter = "H"
        let newstr = summaryTupple[5]
        var token = newstr.components(separatedBy: delimiter)
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
