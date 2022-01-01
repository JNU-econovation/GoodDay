//
//  File.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class GDMissionPerDayDetailViewController: UIViewController {
    
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weekButton: UIButton!
    
    @objc func onTapButton(_ sender: AnyObject) {
        let button = sender as! UIButton
        print("Button was tapped. \(button.titleLabel?.text ?? "")")
   }
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeheight = UIScreen.main.bounds.width
    var contentViewHeight: CGFloat = 0.0
    
    let pickerData = ["DAY 1", "DAY 2", "DAY 3", "DAY 4", "DAY 5", "DAY 6"]
    
    var behavior:MSCollectionViewPeekingBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: screenSizeWidth * 0.119)
        
        // content height
        contentViewHeight = ContentView.frame.height
        
        // add components
        collectionView = getPeekingCollectionView(screenSizeWidth: screenSizeWidth, contentViewHeight: contentViewHeight, collectionView: collectionView)
        ContentView.addSubview(getCollectionViewBackgroundImage(collectionView: collectionView))
        ContentView.addSubview(collectionView)
        ContentView.addSubview(getDetailView(screenSizeWidth: screenSizeWidth, contentViewHeight: contentViewHeight))
        ContentView.addSubview(getweekButton(text: "WEEK 1",originButton: weekButton))
        
        // set next backbar button
        let backBarButtonItem = UIBarButtonItem(title: "GOOD DAY", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func getPeekingCollectionView(screenSizeWidth: CGFloat, contentViewHeight: CGFloat, collectionView: UICollectionView ) -> UICollectionView{
        collectionView.configureForPeekingBehavior(behavior: behavior)
        
        collectionView.backgroundColor = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = CGRect(x: 0, y: 0, width: screenSizeWidth, height: contentViewHeight / 2)
                
        return collectionView
    }
    
    func getCollectionViewBackgroundImage(collectionView: UICollectionView) -> UIImageView {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "MissionPerDayBackground")
        backgroundImageView.frame = CGRect(x: 0, y: contentViewHeight / 4 - 46, width: screenSizeWidth, height: 92)

        backgroundImageView.layer.zPosition = -1
        return backgroundImageView
    }
    
    func getweekButton(text: String, originButton: UIButton) -> UIButton {
        let weekButton = originButton        
        let weekLable = UILabel()
        weekLable.text = text
        weekLable.textColor = .black
        weekLable.font = UIFont(name: "NanumGothicOTF", size: 24)
        weekLable.sizeToFit()
        
        let stringSize = FontUtils().getFontSize(font: weekLable.font, text: text)
        weekButton.frame = CGRect(x: (screenSizeWidth - stringSize.width) / 2, y: (contentViewHeight / 2 - screenSizeWidth * 0.6) / 4  - 20, width: stringSize.width, height: 40)
        
        weekButton.addSubview(weekLable)

        return weekButton
    }
    
    func getDetailView(screenSizeWidth: CGFloat, contentViewHeight: CGFloat) -> UIView {
        var detailView = UIView()
        detailView.frame = CGRect(x:0, y: contentViewHeight/2, width: screenSizeWidth, height: contentViewHeight/2)
        detailView.layer.shadowOpacity = 0.3
        detailView.layer.shadowOffset = CGSize(width: 0, height: -3)
        detailView.layer.shadowRadius = 5
        detailView.backgroundColor = .white
        
        detailView = makeDetails(detailView: detailView)
        
        return detailView
    }
}
