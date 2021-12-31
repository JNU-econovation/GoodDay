//
//  ViewController.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit

class ViewController: UIViewController {

    var nickname: String?
    var firstMbti: String?
    var secondMbti: String?
    var thirdMbti: String?
    var fourthMbti: String?
    var wakeUpTime: Date?
    var sleepTime: Date?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserNameLabel()
    }

    
    func configureUserNameLabel(){
        self.userNameLabel.text = (self.nickname ?? "")  + "님,"
    }

}

