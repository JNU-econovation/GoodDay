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
    @IBOutlet weak var backButton: UIButton!
    
    @objc func onTapButton(_ sender: AnyObject) {
        let button = sender as! UIButton
        print("Button was tapped. \(button.titleLabel?.text ?? "")")
    }
    
    @objc func onTapBackButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
        
    private var stackController = ScrollStackViewController()
    let stackView = ScrollStack()
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeheight = UIScreen.main.bounds.width

    var missionPerDayData: MissionPerDay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        for i in 1...(missionPerDayData!.weeks.count) {
            let oneWeekView = getOneWeekView(index: i)
            let taps = UITapGestureRecognizer(target: self, action: #selector(onTapButton(_:)))
            oneWeekView.addGestureRecognizer(taps)
            
            stackView.addRow(view: oneWeekView)
        }
        
        stackView.isSeparatorHidden = true
        stackController.view = stackView
        stackController.view.frame = contentView.bounds
        contentView.addSubview(stackController.view)
        
        backButton.addTarget(self, action: #selector(onTapBackButton(_:)), for: .touchUpInside)
    }
}

extension GDMissionPerDayWeekViewController {
    func getOneWeekView(index: Int) -> UIView {
        let oneWeekView = UIView()
        
        let tmpLabel = UILabel()
        tmpLabel.text = "WEEK \(index)"
        tmpLabel.textColor = .black
        tmpLabel.textAlignment = .center
        tmpLabel.sizeToFit()

        let textSize = FontUtils().getFontSize(font: tmpLabel.font, text: tmpLabel.text!)
        tmpLabel.frame = CGRect(x: screenSizeWidth / 2  - textSize.width * 3 / 4, y:  20 - textSize.height, width: textSize.width, height: textSize.height)

        let buttonSize = (screenSizeWidth - 10) / 7.3876
        oneWeekView.heightAnchor.constraint(equalToConstant: 80 + buttonSize).isActive = true
       
        oneWeekView.addSubview(tmpLabel)

        var curMissionStatement: missionStatement?
        
        for i in 0...5 {
            if missionPerDayData!.weeks[index - 1].days.count > i {
                if missionPerDayData?.weeks[index - 1].days[i].isSuccess == 1 {
                    curMissionStatement = .missionClear
                } else {
                    curMissionStatement = .missionFail
                }
            } else {
                curMissionStatement = .notExist
            }
            oneWeekView.addSubview(getOneWeekImage(missionState: curMissionStatement!, buttonSize: buttonSize, position: CGSize(width: buttonSize * CGFloat(0.6938 + Double(i)) - 15 + CGFloat((2 * i)), height: CGFloat(40)) ))
        }

        return oneWeekView
    }
    
    func getOneWeekImage(missionState: missionStatement, buttonSize: CGFloat, position: CGSize) -> UIImageView {
        //let missionButton = UIButton()
        var image = UIImage()
        let imageView = UIImageView()
        
        imageView.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        imageView.frame = CGRect(x: position.width, y: position.height, width: buttonSize, height: buttonSize)
        imageView.layer.cornerRadius = buttonSize / 2
        
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4.24)
        
        switch missionState {
        case .missionClear:
            image = UIImage(named: "missionClear")!
        case .missionFail:
            image = UIImage(named: "missionFail")!
        case .notExist:
            image = UIImage(named: "notExist")!
            imageView.layer.shadowOpacity = 0
        }
        
        imageView.image = image
                
        return imageView
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
