//
//  WelcomeViewController.swift
//  GoodDay
//
//  Created by myungsun on 2021/12/31.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStartButton()
    }

    func configureStartButton(){
        // 버튼 속성 값
        self.startButton.titleLabel?.textColor = .white
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.startButton.backgroundColor = UIColor(rgb: 0x0015FF)
        self.startButton.layer.cornerRadius = 13

        
        // 버튼 오토레이아웃 설정
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        self.startButton.widthAnchor.constraint(equalToConstant: 330).isActive = true
        self.startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    // "시작하기" 버튼 클릭 시 이름 설정 화면으로 이동.
    @IBAction func tapStartButton(_ sender: UIButton) {
        let NameSettingVC = NameSettingViewController(nibName: "NameSettingViewController", bundle: nil)
        NameSettingVC.modalPresentationStyle = .overFullScreen
        NameSettingVC.modalTransitionStyle = .crossDissolve
        self.present(NameSettingVC, animated: true, completion: nil)
    }
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
