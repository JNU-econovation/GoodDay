//
//  GDMissionPerDayWeak.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/31.
//


import UIKit
import ScrollStackController

class GDMissionPerDayWeekViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    private var stackController = ScrollStackViewController()
    var stackView = ScrollStack()
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeheight = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...6 {
            var height = 0.0
            stackView.addSubview(getOneWeekView(height: height, index: i))
            stackController.view = stackView
            height += 170
        }
        
        stackController.view.frame = contentView.bounds
        contentView.addSubview(stackController.view)
    }
}

extension GDMissionPerDayWeekViewController {
    func getOneWeekView(height: CGFloat, index: Int) -> UIView {
        let oneWeekView = UIView()
        oneWeekView.frame = CGRect(x: 0, y: height, width: screenSizeWidth, height: 170)
        
        let tmpLabel = UILabel()
        tmpLabel.text = "WEEK \(index)"
        tmpLabel.textColor = .black
        tmpLabel.textAlignment = .center
        tmpLabel.sizeToFit()
        
        oneWeekView.addSubview(tmpLabel)
        
        return oneWeekView
    }
}
