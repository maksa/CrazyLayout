//
//  ClockTranslator.swift
//  CrazyLayout
//
//  Created by Maksa on 11/16/15.
//  Copyright © 2015 MM. All rights reserved.
//

import UIKit

func signum( v : Double ) -> Int {
    return (v < 0) ? -1 : (v > 0) ? 1 : 0
}

class ClockTranslator: NSObject {
    var type : ClockType = ClockType.Twelve
    init( type :ClockType ) {
        self.type = type
    }
    override init() {
        self.type = ClockType.Twelve
    }
    
    func hourToTickMark( hour: Double ) -> Double {
        let tickCount : Double = Double(type.rawValue)
        return (tickCount -  (hour % tickCount - (3*tickCount/12))) % tickCount
    }
    func minutesToHourParts( minute: Double ) -> Double {
        return minute / 60.0
    }
    
    func timeToAngles( time : NSDate ) -> (hrs: Double, min: Double, sec: Double) {
        return (timeHoursAngle(time), minutesToAngle(time), secondsToAngle(time ))
    }
    
    
    func timeHoursAngle( time : NSDate ) -> Double {
        let calendar = NSCalendar.currentCalendar()
        var unit = NSCalendarUnit()
        unit = unit.union(.Hour).union(.Minute).union(.Second)
        let comps = calendar.components( unit, fromDate: time )
        
        let sectionSize = 360 / self.type.rawValue
        let minutesPart : Double = Double(comps.minute) / 60.0 / (self.type.rawValue/12)
        // Angle = -30 * a -90
        let translatedHrs = hourToTickMark(Double(comps.hour) + Double(minutesPart))
        let hrsAngle = translatedHrs * sectionSize

        return Double(hrsAngle)
    }

    func secondsToAngle( time : NSDate ) -> Double {
        let calendar = NSCalendar.currentCalendar()
        var unit = NSCalendarUnit()
        unit = unit.union(.Hour).union(.Minute).union(.Second)
        let comps = calendar.components( unit, fromDate: time )
        return (60 - comps.second + 15 ) * 6.0
    }
    
    func minutesToAngle( time : NSDate ) -> Double {
        let calendar = NSCalendar.currentCalendar()
        var unit = NSCalendarUnit()
        unit = unit.union(.Hour).union(.Minute).union(.Second)
        let comps = calendar.components( unit, fromDate: time )
        return (60 - comps.minute + 15 ) * 6.0

    }
}
