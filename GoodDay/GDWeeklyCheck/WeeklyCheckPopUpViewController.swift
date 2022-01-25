//
//  WeeklyCheckPopUpViewController.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/24.
//

import UIKit

class WeeklyCheckPopUpViewController: UIViewController {

    @IBOutlet var weeklyCheckContainerView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mbtiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weeklyCheckLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let checkImg = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 23,weight: .bold))
    let xmarkImg = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14,weight: .bold))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWeeklyCheckPopUpViews()
    }
    
    func initializeWeeklyCheckPopUpViews(){
        configureWeeklyCheckContainerView()
        configureCheckButton()
        configureCloseButton()
        configureWeekCheckView()
        configureStartButton()
    }
    
    func configureWeeklyCheckContainerView(){
        self.weeklyCheckContainerView.backgroundColor = .black
        self.weeklyCheckContainerView.alpha = 0.8
    }
    
    func configureWeekCheckView(){
        self.popUpView.layer.cornerRadius = 20
    }
    func configureCheckButton(){
        self.checkButton.setImage(checkImg, for: .normal)
        self.checkButton.layer.cornerRadius = self.checkButton.frame.width / 2
        self.checkButton.backgroundColor = .white
        self.checkButton.tintColor = .blue
        self.checkButton.layer.borderWidth = 1
        self.checkButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    func configureCloseButton(){
        self.closeButton.setImage(xmarkImg, for: .normal)
        self.closeButton.backgroundColor = .white
        self.closeButton.tintColor = .lightGray
        
    }

    func configureStartButton() {
        self.startButton.titleLabel?.textColor = .white
        self.startButton.backgroundColor = .blue
        self.startButton.layer.cornerRadius = 20
        self.startButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }

    @IBAction func tapStartButton(_ sender: UIButton) {
    }
    


}
