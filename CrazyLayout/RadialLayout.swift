//
//  RadialLayout.swift
//  CrazyLayout
//
//  Created by Maksa on 11/6/15.
//  Copyright © 2015 MM. All rights reserved.
//

import UIKit


class RadialLayout: UICollectionViewLayout {

    var clocks : [ Clock ]?
    
    var ( hrshandradius, minhandradius, sechandradius ) : ( CGFloat, CGFloat, CGFloat ) = ( 0.0, 0.0, 0.0 )
    var attribs : Array<Array<UICollectionViewLayoutAttributes>> = []
    var supplementaryAttribs : Dictionary<String, Array<UICollectionViewLayoutAttributes>> = Dictionary<String, Array<UICollectionViewLayoutAttributes>>()
    var headerHeight = 24.0

    override class func invalidationContextClass() -> AnyClass {
        return ClockHandsInvalidationContext.self
    }
    
    override func collectionViewContentSize() -> CGSize {
        let sectionCount = self.collectionView?.numberOfSections()
        let size = CGSize( width: CGFloat(self.collectionView!.bounds.size.width ),
            height: CGFloat( self.collectionView!.bounds.size.width *  sectionCount! + sectionCount! * headerHeight ))
        
        return size
    }
    
    override func prepareLayout() {
        
        NSLog( "prepareLayout" )
        self.attribs.removeAll()
        self.supplementaryAttribs[ UICollectionElementKindSectionHeader ] = []
        self.supplementaryAttribs[ ViewConstants.SupplementaryViewDotKind ] = []
        self.supplementaryAttribs[ ViewConstants.SupplementaryViewLargeHandKind ] = []
        self.supplementaryAttribs[ ViewConstants.SupplementaryViewSmallHandKind ] = []
        self.supplementaryAttribs[ ViewConstants.SupplementaryViewSecondsHandKind] = []
        
        let sectionCount = self.collectionView?.numberOfSections()
        var verticalOffset = 0.0
        
        for section in 0...sectionCount!-1 {
            self.attribs.append([])
            let count = self.collectionView!.numberOfItemsInSection( section )
            let segment = 360.0/count
            let radius = Double( self.collectionView!.bounds.size.width / 2 ) * 0.80
            
            let frame = self.collectionView!.frame
            let screenCenter = CGPoint( x: frame.size.width / 2, y: frame.size.height / 2 )
        
            let clockCenter = CGPoint( x: screenCenter.x, y: screenCenter.x + CGFloat(headerHeight))

            let headerIP = NSIndexPath(forItem: 0, inSection: section )
            let headerAtts = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withIndexPath: headerIP )
            
            headerAtts.size = CGSize(width: (self.collectionView?.bounds.width)!, height: CGFloat(headerHeight) )
            headerAtts.frame = CGRect(x: 0.0, y: verticalOffset, width: Double((self.collectionView?.bounds.width)!), height: headerHeight )
            
            self.attribs[section].append( headerAtts )
            
            self.supplementaryAttribs[ UICollectionElementKindSectionHeader ]?.append( headerAtts )
            
            
            let dotAtts = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ViewConstants.SupplementaryViewDotKind, withIndexPath: headerIP )
            dotAtts.center = CGPoint(x: clockCenter.x, y: clockCenter.y + CGFloat(verticalOffset))
            dotAtts.size = CGSize( width: 10.0, height: 10.0 )

            self.attribs[section].append( dotAtts )
            self.supplementaryAttribs[ ViewConstants.SupplementaryViewDotKind ]?.append( dotAtts )
            
            let minutesHandSize : CGFloat = CGFloat(radius) * 0.7
            let largeHandAtts = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ViewConstants.SupplementaryViewLargeHandKind, withIndexPath: headerIP )
            
            largeHandAtts.center = CGPoint(x: clockCenter.x, y: clockCenter.y + CGFloat(verticalOffset))
            largeHandAtts.size = CGSize( width: minutesHandSize, height: 4.0)
            largeHandAtts.transform = CGAffineTransformMakeTranslation( minutesHandSize/2, 0 )
            var shift = CGAffineTransformMakeTranslation( minutesHandSize/2, 0 )
            var rotate = CGAffineTransformMakeRotation( CGFloat(45.0.degrees) )
            largeHandAtts.transform = CGAffineTransformConcat( shift, rotate )
            
            self.attribs[section].append( largeHandAtts )
            self.supplementaryAttribs[ ViewConstants.SupplementaryViewLargeHandKind ]?.append( largeHandAtts )

            let hourHandSize : CGFloat = CGFloat(radius) * 0.5
            let smallHandAtts = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ViewConstants.SupplementaryViewSmallHandKind, withIndexPath: headerIP )
            smallHandAtts.center = CGPoint(x: clockCenter.x, y: clockCenter.y + CGFloat(verticalOffset))
            smallHandAtts.size = CGSize( width: hourHandSize, height: 4.0)
            
            shift = CGAffineTransformMakeTranslation(hourHandSize/2, 0)
            rotate = CGAffineTransformMakeRotation( CGFloat(70.0.degrees) )
            smallHandAtts.transform = CGAffineTransformConcat( shift, rotate )
            
            self.attribs[section].append( smallHandAtts )
            self.supplementaryAttribs[ ViewConstants.SupplementaryViewSmallHandKind ]?.append( smallHandAtts )
            
            let secondsHandSize : CGFloat = CGFloat(radius) * 0.95
            let secondsHandAtts = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ViewConstants.SupplementaryViewSecondsHandKind, withIndexPath: headerIP)
            secondsHandAtts.center = CGPoint( x: clockCenter.x, y: clockCenter.y + CGFloat(verticalOffset))
            secondsHandAtts.size = CGSize( width: secondsHandSize, height: 4.0)
            shift = CGAffineTransformMakeTranslation( secondsHandSize/2, 0 )
            rotate = CGAffineTransformMakeRotation( CGFloat(135.0.degrees) )
            secondsHandAtts.transform = CGAffineTransformConcat( shift, rotate )
            
            self.attribs[section].append( secondsHandAtts )
            self.supplementaryAttribs[ ViewConstants.SupplementaryViewSecondsHandKind ]?.append( secondsHandAtts )
            
            for i in 0...count-1
            {
                let xPos = Double( clockCenter.x ) + radius * cos(( segment * i ).degrees )
                let yPos = Double( clockCenter.y ) - radius * sin(( segment * i ).degrees ) + verticalOffset
                let center = CGPoint( x: xPos, y: yPos )
                let ip = NSIndexPath( forItem: i, inSection: section )
                let atts = UICollectionViewLayoutAttributes( forCellWithIndexPath: ip )
                atts.center = center
                atts.size = CGSize( width: 46.0, height: 32.0 )
                self.attribs[section].append( atts )
            }
            let clockHeight = self.collectionView?.bounds.size.width
            verticalOffset += Double(clockHeight!) + headerHeight // header size
            
            (hrshandradius, minhandradius, sechandradius ) = (hourHandSize, minutesHandSize, secondsHandSize)

        }
        
        
        
        NSLog("did prepareLayout")
    }
    
    func indexPathsForHands() -> [ NSIndexPath ] {
        let sectionCount = self.collectionView?.numberOfSections()
        var ips = [ NSIndexPath ]()
        for section in 0...sectionCount!-1 {
            ips.append( NSIndexPath(forItem: 0, inSection: section ) )
        }

        return ips
    }
    
    override func invalidateLayoutWithContext(context: UICollectionViewLayoutInvalidationContext) {
        NSLog( "Invalidating layout with Context" )
        if( context is ClockHandsInvalidationContext ) {
            let timerContext = context as! ClockHandsInvalidationContext
            switch( timerContext.changeType ) {
            case .OTHER:
                NSLog( "Ovaj NIJE moj - NEKI DRUGI RAZLOG" )
                super.invalidateLayoutWithContext( context )
            case .TIME:
                NSLog("time to move hands")
                let handsIPs = indexPathsForHands()
                context.invalidateSupplementaryElementsOfKind(ViewConstants.SupplementaryViewLargeHandKind, atIndexPaths: handsIPs )
                context.invalidateSupplementaryElementsOfKind(ViewConstants.SupplementaryViewSmallHandKind, atIndexPaths: handsIPs )
                context.invalidateSupplementaryElementsOfKind(ViewConstants.SupplementaryViewSecondsHandKind, atIndexPaths: handsIPs )
                super.invalidateLayoutWithContext( context )
            }
        } else {
            NSLog( "default context" )
            super.invalidateLayoutWithContext( context )
        }
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }
    
    // used when data changes, i.e. added, reloaded, etc.
    override func  layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        NSLog( "layoutAttribsForElementsInRect" )
        return attribs[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        NSLog( "layoutAttribsForElementsInRect\(rect)" )
        return attribs.flatMap({$0})
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> (UICollectionViewLayoutAttributes!) {
        
        let clock =  self.clocks![indexPath.section]
        let now  = NSDate()
        
        let translator = ClockTranslator( type: clock.myClockType )
        let ( hrs, min, sec ) = translator.timeToAngles( now )
        
        NSLog( "attribs for supplements of kind: \(elementKind) at \(indexPath.section):\(indexPath.row)" )
        var attsset : Array<UICollectionViewLayoutAttributes> = self.supplementaryAttribs[elementKind]!
        if let i = attsset.indexOf({$0.indexPath == indexPath}) {
            let att : UICollectionViewLayoutAttributes = attsset[i]
            switch elementKind {
            case ViewConstants.SupplementaryViewSmallHandKind:
                let shift = CGAffineTransformMakeTranslation( hrshandradius/2, 0 )
                let rotate = CGAffineTransformMakeRotation( CGFloat( -hrs.degrees) )
                att.transform = CGAffineTransformConcat( shift, rotate )
            case ViewConstants.SupplementaryViewLargeHandKind:
                let shift = CGAffineTransformMakeTranslation( minhandradius/2, 0 )
                let rotate = CGAffineTransformMakeRotation( CGFloat( -min.degrees) )
                att.transform = CGAffineTransformConcat( shift, rotate )
            case ViewConstants.SupplementaryViewSecondsHandKind:
                let shift = CGAffineTransformMakeTranslation( sechandradius/2, 0 )
                let rotate = CGAffineTransformMakeRotation( CGFloat( -sec.degrees) )
                att.transform = CGAffineTransformConcat( shift, rotate )
            default:
                att.transform = CGAffineTransformConcat(att.transform, CGAffineTransformMakeRotation( CGFloat( -sec.㎭)))

            }
            return att
        }
        
        return nil
        
    }
    
}
