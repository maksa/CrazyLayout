//
//  Sanity.swift
//  CrazyLayout
//
//  Created by Maksa on 11/9/15.
//  Copyright © 2015 MM. All rights reserved.
//

import UIKit

func *(left: Double, right: Int ) -> Double {
    return left * Double(right)
}

func *(left: Int, right: Double ) -> Double {
    return Double(left) * right
}

func *(left: CGFloat, right: Int ) -> Double {
    return left * Double(right)
}

func *(left: CGFloat, right: Double ) -> Double {
    return Double(left) * right
}

func /(left: CGFloat, right: Int ) -> Double {
    return Double(left) / Double(right)
}

func /(left: Int, right: CGFloat ) -> Double {
    return Double(left) / Double(right)
}


func /(left: Double, right: Int ) -> Double {
    return left / Double(right)
}

func /(left: Int, right: Double ) -> Double {
    return Double(left) / right
}

extension CGFloat {
    public var double: Double { return Double(self) }
}

extension Double {
    public var degrees: Double { return self * M_PI / 180 }
    public var ㎭: Double { return self * 180 / M_PI }
}
