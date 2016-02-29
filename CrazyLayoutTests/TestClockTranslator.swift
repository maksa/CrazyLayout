//
//  TestClockTranslator.swift
//  CrazyLayout
//
//  Created by Maksa on 11/16/15.
//  Copyright © 2015 MM. All rights reserved.
//

import XCTest


class TestClockTranslator: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTranslateNoonToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        let noon = NSDate.withTime( 12, m: 0, s: 0)
        let noonAngle = translator.timeHoursAngle( noon )
        XCTAssertEqual( 90.0, noonAngle )
    }

    func testTranslateClockToTickMarkNumber() {
        
    }
    
    func testTranslate6oclockToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        let six = NSDate.withTime( 6, m: 0, s: 0)
        let angle = translator.timeHoursAngle( six )
        XCTAssertEqual( 270.0, angle )
    }
    
    func testTranslate4oclockToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        let four = NSDate.withTime( 16, m: 0, s: 0)
        let angle = translator.timeHoursAngle( four )
        XCTAssertEqual( 330.0, angle )
    }
    
    func testTranslate1oclockToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        let one = NSDate.withTime( 1, m: 0, s: 0)
        let angle = translator.timeHoursAngle( one )
        XCTAssertEqual( 60.0, angle )
    }
    
    func testTranslate3pmoclockToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        let six = NSDate.withTime( 15, m: 0, s: 0)
        let angle = translator.timeHoursAngle( six )
        XCTAssertEqual( 0.0, angle )
    }
    
    func testTranslate9oclockToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        let nine = NSDate.withTime( 9, m: 0, s: 0)
        let angle = translator.timeHoursAngle( nine )
        XCTAssertEqual( 180.0, angle )
    }

    func testTranslate20hrsToAngles() {
        let translator : ClockTranslator = ClockTranslator()
        var eight = NSDate.withTime( 20, m: 0, s: 0)
        let angle = translator.timeHoursAngle( eight )
        XCTAssertEqual( 210.0, angle )
        eight = NSDate.withTime( 8, m: 0, s: 0)
        XCTAssertEqual( 210.0, angle )
    }
    
    func testTranslate9ToTick() {
        let translator : ClockTranslator = ClockTranslator()
        var tickForNine = translator.hourToTickMark( 9.0 )
        XCTAssertEqual( tickForNine , 6.0 )
        tickForNine = translator.hourToTickMark( 21.0 )
        XCTAssertEqual( tickForNine , 6.0 )
        
        var tickForThree = translator.hourToTickMark( 3.0 )
        XCTAssertEqual( tickForThree , 0.0 )
        tickForThree = translator.hourToTickMark( 15 )
        XCTAssertEqual( tickForThree , 0.0 )
        
        var tickForFour = translator.hourToTickMark( 4.0 )
        XCTAssertEqual( tickForFour , 11.0 )
        tickForFour = translator.hourToTickMark( 16.0 )
        XCTAssertEqual( tickForFour , 11.0 )
    }
    
    func testTranslateWithMinutes() {
        let translator : ClockTranslator = ClockTranslator()
        var time = NSDate.withTime(15, m: 30, s: 0)
        var tickFor1259 = translator.timeHoursAngle( time )
        XCTAssertEqualWithAccuracy( tickFor1259, 345.0, accuracy: 0.9)
        time = NSDate.withTime(15, m: 20, s: 0)
        tickFor1259 = translator.timeHoursAngle( time )
        XCTAssertEqualWithAccuracy( tickFor1259, 350.0, accuracy: 0.9)
        
    }
    
}
