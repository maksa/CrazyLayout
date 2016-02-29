//
//  ClockHandsInvalidationContext.swift
//  CrazyLayout
//
//  Created by Maksa on 11/10/15.
//  Copyright © 2015 MM. All rights reserved.
//

import UIKit

enum ChangeType {
    case TIME
    case OTHER
}

class ClockHandsInvalidationContext: UICollectionViewLayoutInvalidationContext {
    var changeType : ChangeType = .OTHER
}
