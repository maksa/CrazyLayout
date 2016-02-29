//
//  DateExtensions.swift
//  CrazyLayout
//
//  Created by Maksa on 11/16/15.
//  Copyright © 2015 MM. All rights reserved.
//

import Foundation

extension NSDate {
    class func withTime( h : Int, m : Int, s: Int ) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.calendar = calendar
        components.hour = h
        components.minute = m
        components.second = s
        return components.date!
    }
}