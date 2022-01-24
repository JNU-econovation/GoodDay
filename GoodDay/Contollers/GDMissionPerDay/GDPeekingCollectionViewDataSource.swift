//
//  GDPeekingCollectionViewDataSource.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import FirebaseFirestore

extension GDMissionPerDayDetailViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return missionPerDayData!.weeks[(curWeek ?? 1) - 1].days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missionPerDayData!.weeks[(curWeek ?? 1) - 1].days.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        cell.subviews.forEach {$0.removeFromSuperview()}
        cell.backgroundColor = .none
        
        let innerLabel = getInnerCircleLabel(cell: cell)
        let blurEffect = getBlurEffetCircleView(innerLabel: innerLabel)
        let visualEffectView = getBlurEffectView(style: .regular)
        
        if missionPerDayData?.weeks[(curWeek ?? 1) - 1].days[indexPath.item].isSuccess != 1{
            innerLabel.addSubview(blurEffect)
        } else {
            innerLabel.addSubview(visualEffectView)
        }
        
        innerLabel.addSubview(getInnerCircleTextLabel(text: pickerData[indexPath.item], innerLabel: innerLabel))
        cell.addSubview(innerLabel)
        
        return cell
    }
    
    // 버튼 누를때
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
           let pressedDownTransform = CGAffineTransform(scaleX: 0.98, y: 0.98)
           UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: { cell.transform = pressedDownTransform })
        }
        
        var isSuceess: Int?
        if missionPerDayData?.weeks[(curWeek ?? 1) - 1].days[indexPath.item].isSuccess == 1 {
            isSuceess = 0
        } else {
            isSuceess = 1
        }
        
        missionPerDayData?.weeks[(curWeek ?? 1) - 1].days[indexPath.item].isSuccess = isSuceess!
        do {
            docRef?.updateData((try missionPerDayData?.toDictionary().self)!)
        } catch {
            print("Not Changed!!")
        }
    }
    
    // 버튼 뗄때
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let innerLabel = getInnerCircleLabel(cell: cell)
            let visualEffectView = getBlurEffectView(style: .regular)
            let blurEffectView = getBlurEffetCircleView(innerLabel: innerLabel)
            let checkImage = UIImage(named: "check")
            let imageView = UIImageView(image: checkImage)

            imageView.frame =  CGRect(x: screenSizeWidth * 0.2, y: screenSizeWidth * 0.2, width: screenSizeWidth * 0.2, height: screenSizeWidth * 0.2  )
            imageView.tag = 20
            
            let textView = getInnerCircleTextLabel(text: "DAY \(indexPath.item + 1)", innerLabel: innerLabel)
            
            
            visualEffectView.alpha = 0
            imageView.alpha = 0
            textView.alpha = 0
            blurEffectView.alpha = 0
            
            let originalTransform = CGAffineTransform(scaleX: 1, y: 1)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: [.curveEaseInOut]) {
                cell.transform = originalTransform
            } completion: { [self] finished in
                if self.missionPerDayData?.weeks[(self.curWeek ?? 1) - 1].days[indexPath.item].isSuccess == 0 {

                    UIView.animate(withDuration: 0.8, delay: 0, options: .transitionCrossDissolve) {

                        cell.subviews.forEach {
                            if $0.tag == 5 {
                                $0.subviews.forEach { tmpView in
                                    if tmpView.tag == 11 { tmpView.removeFromSuperview() } // textview
                                    if tmpView.tag == 12 {tmpView.alpha = 0} // blurview
                                    if tmpView.tag == 20 { tmpView.removeFromSuperview() } // imageview
                                }
                            }
                        }
                        innerLabel.addSubview(blurEffectView)
                        blurEffectView.alpha = 1
                        cell.addSubview(innerLabel)
                    } completion: { finished in
                        UIView.animate(withDuration: 0.6, delay: 0, options: .transitionCrossDissolve) {
                            cell.subviews.forEach {
                                if $0.tag == 5 {
                                    $0.subviews.forEach { tmpView in
                                        if tmpView.tag == 12 { tmpView.removeFromSuperview()} // blurview
                                    }
                                }
                            }
                            innerLabel.addSubview(textView)
                            textView.alpha = 1
                        }
                    }
                    return
                }
                
                UIView.animate(withDuration: 0.8, delay: 0, options: .transitionCrossDissolve) {
                    cell.subviews.forEach {
                        if $0.tag == 5 { //innerlabel
                            $0.subviews.forEach{tmpView in
                                if tmpView.tag == 11 { tmpView.removeFromSuperview() } // textview
                                if tmpView.tag == 12 { tmpView.removeFromSuperview() } // blurview
                                if tmpView.tag == 20 { tmpView.removeFromSuperview() } // imageview
                            }
                        }
                    }
                    innerLabel.addSubview(visualEffectView)
                    innerLabel.addSubview(imageView)
                    visualEffectView.alpha = 1
                    imageView.alpha = 1
                    cell.addSubview(innerLabel)
                } completion: { finished in
                    UIView.animate(withDuration: 0.6, delay: 0.5, options: .transitionCrossDissolve) {
                        imageView.alpha = 0
                        innerLabel.addSubview(textView)
                        textView.alpha = 1
                    }
                }
            }
        }
    }
    
    func getInnerCircleLabel(cell: UICollectionViewCell) -> UILabel{
        let innerLabel = UILabel(frame: CGRect(x: (cell.frame.width - screenSizeWidth * 0.6) / 2, y: ((contentViewHeight / 2) - screenSizeWidth * 0.6) / 2 , width: screenSizeWidth * 0.6, height: screenSizeWidth * 0.6))
        
        // Make Shape
        innerLabel.layer.cornerRadius = screenSizeWidth * 0.3
        innerLabel.layer.shadowOpacity = 0.4
        innerLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        innerLabel.layer.shadowRadius = 3
        
        innerLabel.tag = 5
        
        return innerLabel
    }
    
    func getBlurEffetCircleView(innerLabel: UILabel) -> GDBlurEffectView{
        let blurEffect = GDBlurEffectView()
        blurEffect.intensity = 3
        blurEffect.frame = innerLabel.bounds
        blurEffect.layer.cornerRadius = screenSizeWidth * 0.3
        blurEffect.clipsToBounds = true
        blurEffect.tag = 10

        return blurEffect
    }
    
    func getInnerCircleTextLabel(text: String, innerLabel: UILabel) -> UILabel {
        let textLabel = UILabel()
        textLabel.frame = innerLabel.bounds
        textLabel.text = text
        textLabel.textColor = .white
        textLabel.font = UIFont(name: "NotoSansKR-Bold", size: 44)
        textLabel.textAlignment = .center
        textLabel.tag = 11
        
        return textLabel
    }
    
    func getBlurEffectView(style: UIBlurEffect.Style) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        visualEffectView.frame = CGRect(x: 0, y: 0, width: screenSizeWidth * 0.6, height: screenSizeWidth * 0.6)
        visualEffectView.clipsToBounds = true; // 없으면 안됨
        visualEffectView.layer.cornerRadius = screenSizeWidth * 0.3
        
        visualEffectView.tag = 12
        
        return visualEffectView
    }
}
