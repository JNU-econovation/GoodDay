//
//  GDPeekingCollectionViewDataSource.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

extension GDMissionPerDayDetailViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.subviews.forEach {$0.removeFromSuperview()}
        cell.backgroundColor = .none
        
        let innerLabel = getInnerCircleLabel(cell: cell, text: pickerData[indexPath.item])
        cell.addSubview(innerLabel)
        
        return cell
    }
    
    func getInnerCircleLabel(cell: UICollectionViewCell, text: String) -> UILabel{
        let innerLabel = UILabel(frame: CGRect(x: (cell.frame.width - screenSizeWidth * 0.6) / 2, y: ((contentViewHeight / 2) - screenSizeWidth * 0.6) / 2 , width: screenSizeWidth * 0.6, height: screenSizeWidth * 0.6))
        
        // Set Text
        let textLabel = UILabel()
        textLabel.frame = innerLabel.bounds
        textLabel.text = text
        textLabel.textColor = .white
        textLabel.font = UIFont(name: "NanumSquareOTFEB", size: 44)
        textLabel.textAlignment = .center
        
        // Make Shape
        innerLabel.layer.cornerRadius = screenSizeWidth * 0.3
        innerLabel.layer.shadowOpacity = 0.4
        innerLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        innerLabel.layer.shadowRadius = 3
                
        let blurEffect = getBlurEffetCircleView(innerLabel: innerLabel)
        innerLabel.addSubview(blurEffect)
        innerLabel.addSubview(textLabel)
        
        return innerLabel
    }
    
    func getBlurEffetCircleView(innerLabel: UILabel) -> GDBlurEffectView{
        let blurEffect = GDBlurEffectView()
        blurEffect.intensity = 3
        blurEffect.frame = innerLabel.bounds
        blurEffect.layer.cornerRadius = screenSizeWidth * 0.3
        blurEffect.clipsToBounds = true

        return blurEffect
    }
}
