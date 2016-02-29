//
//  Clock.swift
//  CrazyLayout
//
//  Created by Maksa on 11/9/15.
//  Copyright © 2015 MM. All rights reserved.
//

import UIKit

enum ClockType : Int {
    case Twelve = 12
    case TwentyFour = 24
}

class Clock: NSObject {
    var myClockType : ClockType
    var gmtoffsetminutes : Int = 0
    var name : String = "Unknown"
    init( clockname: String, gmtoffset: Int, clockType: ClockType ) {
        name = clockname
        gmtoffsetminutes = gmtoffset
        myClockType = clockType
    }
}

