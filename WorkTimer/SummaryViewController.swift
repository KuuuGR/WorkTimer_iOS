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
        super.viewWillAppear(animated) // No need for semicolon
        workStartLabel.text = summaryTupple[0]
        workEndLabel.text = summaryTupple[1]
        jobLabel.text = summaryTupple[2]
        drinkLabel.text = summaryTupple[3]
        eatLabel.text = summaryTupple[4]
        logTimeLabel.text = summaryTupple[5]
    }

    

    override func viewDidLoad() {
        
//        workStartLabel.text = summaryTupple[0]
//        workEndLabel.text = summaryTupple[1]
//        jobLabel.text = summaryTupple[2]
//        drinkLabel.text = summaryTupple[3]
//        eatLabel.text = summaryTupple[4]
//        logTimeLabel.text = summaryTupple[5]
        print (summaryTupple)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func BackButtonAction(_ sender: Any) {
        dismissDetail()
    }
    
}
