//
//  GDMissionPerDayWeak.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/31.
//


import UIKit

class GDMissionPerDayWeekViewController: UIViewController {
    @IBOutlet weak var weekContentView: UIView!
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeheight = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weekCount = 6
        // scroll view 높이 맞추기.
        //weekContentView.heightAnchor.constraint(equalToConstant: CGFloat(weekCount) * 2 * (135 + 52 * 2)).isActive = true
        weekContentView.heightAnchor.constraint(equalToConstant: 1500).isActive = true
        
        var height = 0.0
        for i in 1...weekCount {
            weekContentView.addSubview(getOneWeekView(height: height, index: i))
            height += (135 + 52 * 2)
        }
    }
}

extension GDMissionPerDayWeekViewController {
    func getOneWeekView(height: CGFloat, index: Int) -> UIView {
        let oneWeekView = UIView()
        oneWeekView.frame = CGRect(x: 0, y: height, width: screenSizeWidth, height: 170)
        
        let tmpLabel = UILabel()
        tmpLabel.text = "WEEK \(index)"
        tmpLabel.textColor = .black
        tmpLabel.sizeToFit()
        tmpLabel.systemLayoutSizeFitting(.zero, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .defaultHigh)
        
        oneWeekView.addSubview(tmpLabel)
        
        return oneWeekView
    }
}
