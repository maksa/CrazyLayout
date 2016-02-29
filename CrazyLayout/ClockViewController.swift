//
//  ViewController.swift
//  CrazyLayout
//
//  Created by Maksa on 11/6/15.
//  Copyright © 2015 MM. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var clocks : [ Clock ] = []
    let clockLabelValues : [ ClockType : [Int] ] = [ .Twelve : [ 3, 2, 1, 12, 11, 10, 9, 8, 7, 6, 5, 4 ],
        .TwentyFour : [ 6, 5, 4, 3, 2, 1, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7  ]]
    
    override func viewDidLoad() {
        self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        clocks.append( Clock(clockname: "Beograd", gmtoffset: 60, clockType: ClockType.TwentyFour ))
        clocks.append( Clock(clockname: "Chicago", gmtoffset: -6 * 60 , clockType: ClockType.Twelve ))
        clocks.append( Clock(clockname: "Tokio", gmtoffset: 9 * 60, clockType: ClockType.Twelve ))
        clocks.append( Clock(clockname: "Singapore", gmtoffset: 8 * 60, clockType: ClockType.Twelve ))
    
        let nib = UINib(nibName: "ClockHeader", bundle: nil)
        collectionView.registerNib(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headercell")
        
        let dotNib = UINib( nibName: "Dot", bundle: nil )
        collectionView.registerNib(dotNib, forSupplementaryViewOfKind: ViewConstants.SupplementaryViewDotKind, withReuseIdentifier: "dotcell")
        
        let smallHandNib = UINib(nibName: "smallhand", bundle: nil )
        collectionView.registerNib(smallHandNib, forSupplementaryViewOfKind:ViewConstants.SupplementaryViewSmallHandKind, withReuseIdentifier: "smallhand")
        
        let largeHandNib = UINib(nibName: "largehand", bundle: nil )
        collectionView.registerNib(largeHandNib, forSupplementaryViewOfKind:ViewConstants.SupplementaryViewLargeHandKind, withReuseIdentifier: "largehand")
        
        let secondsHandNib = UINib(nibName: "secondshand", bundle: nil )
        collectionView.registerNib(secondsHandNib, forSupplementaryViewOfKind: ViewConstants.SupplementaryViewSecondsHandKind, withReuseIdentifier: "secondshand")
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateClock", userInfo: nil, repeats: true)
        
        self.collectionView.collectionViewLayout .setValue(clocks, forKey: "clocks")
    }

    func updateClock() {
        var range = NSRange()
        range.location = 0
        range.length = clocks.count
        let changeContext = ClockHandsInvalidationContext()
        changeContext.changeType = .TIME
        self.collectionView.collectionViewLayout.invalidateLayoutWithContext( changeContext )        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return clocks.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clocks[section].myClockType.rawValue
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let clock = clocks[ indexPath.section ]
//        NSLog("cell for ip:\(indexPath)")
        var cell : CrazyCell;
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("crazycell", forIndexPath: indexPath ) as! CrazyCell
        let name = "\(clockLabelValues[clock.myClockType]![indexPath.row])"
        cell.label.text = name
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch( kind ) {
        case ViewConstants.SupplementaryViewDotKind:
            let dot : UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(ViewConstants.SupplementaryViewDotKind, withReuseIdentifier: "dotcell", forIndexPath: indexPath )
            return dot
        case UICollectionElementKindSectionHeader:
            let header : ClockHeaderCell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headercell", forIndexPath: indexPath ) as! ClockHeaderCell
            header.locationLabel.text = self.clocks[indexPath.section].name
            return header
            
        case ViewConstants.SupplementaryViewLargeHandKind:
            
            let largeHand = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "largehand", forIndexPath: indexPath)
            largeHand.layer.borderColor = UIColor(red:0, green: 1.0, blue:0, alpha: 1.0).CGColor
            return largeHand
            
        case ViewConstants.SupplementaryViewSmallHandKind:
            
            let smallHand = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "smallhand", forIndexPath: indexPath)
            smallHand.layer.borderColor = UIColor(red:0, green: 0, blue: 1.0, alpha: 1.0).CGColor
            return smallHand
        case ViewConstants.SupplementaryViewSecondsHandKind:
            let secondsHand = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "secondshand", forIndexPath: indexPath)
            secondsHand.layer.borderColor = UIColor(red:1, green: 0, blue: 0, alpha: 1.0).CGColor
            return secondsHand

        default:
            let header : ClockHeaderCell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headercell", forIndexPath: indexPath ) as! ClockHeaderCell
            header.locationLabel.text = self.clocks[indexPath.section].name
            return header
        }
        
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        NSLog("će u tranziciju")
        self.collectionView.collectionViewLayout.invalidateLayout()
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
}

