//
//  globalValues.swift
//  WorkTimer
//
//  Created by Grzesiek Kulesza on 10/04/2019.
//  Copyright © 2019 Grzesiek Kulesza. All rights reserved.
//

import Foundation

var summaryTupple: [String] = ["","","","","",""]
var timesTupple: [String] = ["","","","","","","","","","","","",""]

struct workingData {
    var startTime: Date?
    var coffeTimeSec: Int = 0
    var workTimeSec: Int = 0
    var eatTimeSec: Int = 0
    var cardTimeSec: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    
}


