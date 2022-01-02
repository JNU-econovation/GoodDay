//
//  GDMissionPerDayWeak.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/31.
//


import UIKit
import ScrollStackController
import EMTNeumorphicView

class GDMissionPerDayWeekViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    @objc func onTapButton(_ sender: AnyObject) {
        let button = sender as! UIButton
        print("Button was tapped. \(button.titleLabel?.text ?? "")")
    }
    
    private var stackController = ScrollStackViewController()
    let stackView = ScrollStack()
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeheight = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...6 {
            stackView.addRow(view: getOneWeekView(index: i))
        }
        
        stackView.isSeparatorHidden = true
        stackController.view = stackView
        stackController.view.frame = contentView.bounds
        contentView.addSubview(stackController.view)
    }
}

extension GDMissionPerDayWeekViewController {
    func getOneWeekView(index: Int) -> UIView {
        let oneWeekView = UIView()
        //oneWeekView.frame = CGRect(x: 0, y: height, width: screenSizeWidth, height: 170)
        oneWeekView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let tmpLabel = UILabel()
        tmpLabel.text = "WEEK \(index)"
        tmpLabel.textColor = .black
        tmpLabel.textAlignment = .center
        tmpLabel.sizeToFit()
        
        oneWeekView.addSubview(tmpLabel)
        oneWeekView.addSubview(getOneWekButton(missionState: .missonClaer, buttonSize: 50, position: CGSize(width: 10, height: 10)))
        oneWeekView.addSubview(getOneWekButton(missionState: .missionFail, buttonSize: 50, position: CGSize(width: 60, height: 10)))
        oneWeekView.addSubview(getOneWekButton(missionState: .notExist, buttonSize: 50, position: CGSize(width: 110, height: 10)))
        
        return oneWeekView
    }
    
    func getOneWeekImage(missionState: missionStatement, buttonSize: CGFloat, position: CGSize) -> UIImageView {
        let imageView = 
    }
    
    func getOneWekButton(missionState: missionStatement, buttonSize: CGFloat, position: CGSize) -> UIButton {
        let missionButton = UIButton()
        let gradientLayer = CAGradientLayer()
        
        var colors: [CGColor] = []
        
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 1)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.3)
        gradientLayer.locations = [0, 1]
        
        missionButton.frame = CGRect(x: position.width, y: position.height, width: buttonSize, height: buttonSize)
        missionButton.layer.cornerRadius = buttonSize / 2
        gradientLayer.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        gradientLayer.cornerRadius = buttonSize / 2

        switch missionState {
        case .missonClaer:
            colors = [
                UIColor(red: 0, green: 0.082, blue: 1, alpha: 0.9).cgColor,
                UIColor(red: 0, green: 0.082, blue: 1, alpha: 0.35).cgColor
            ]
            missionButton.layer.shadowOpacity = 0.4
            missionButton.layer.shadowOffset = CGSize(width: 0, height: 4.23)
            missionButton.layer.shadowRadius = 4
            
        case .missionFail:
            colors = [
                UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
                UIColor(red: 0.006, green: 0, blue: 0.308, alpha: 0.41).cgColor,
                UIColor(red: 0.02, green: 0, blue: 1, alpha: 0.4).cgColor
            ]
            gradientLayer.locations = [0, 1, 1]
            missionButton.layer.shadowOpacity = 0.4
            missionButton.layer.shadowOffset = CGSize(width: 0, height: 4.23)
            missionButton.layer.shadowRadius = 4

        case .notExist:
            colors = [
                UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
            ]
            gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.49, b: 0.85, c: -0.85, d: 0.49, tx: 0.66, ty: -0.16))
        }

        gradientLayer.colors = colors
        
        missionButton.layer.addSublayer(gradientLayer)
        
        missionButton.backgroundColor = .white
        missionButton.layer.borderColor = .init(gray: 0, alpha: 1)
        missionButton.layer.borderWidth = 0.05
        missionButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        
        return missionButton
    }
}
