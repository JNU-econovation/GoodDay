//
//  GDPeekingCollectionView.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

extension GDMissionPerDayDetailViewController: UICollectionViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        curDay = behavior.currentIndex + 1
        missionIndex = missionPerDayData!.weeks[curWeek! - 1].days[curDay - 1].missionId
        
        detailView.subviews.forEach{$0.removeFromSuperview()}
        detailView = makeDetails(detailView: detailView)
        detailView.setNeedsDisplay()
        detailView.layoutIfNeeded()
    }
}
