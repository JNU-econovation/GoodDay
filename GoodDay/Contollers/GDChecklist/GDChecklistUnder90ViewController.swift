//
//  GDChecklistUnder90.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/26.
//


import UIKit

class GDChecklistUnder90ViewController: UIViewController {
    
    @IBOutlet var weeklyCheckContainerView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weeklyCheckContainerView.layer.cornerRadius = 20
        configureStartButton()
        startButton.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)
    }

    func configureStartButton() {
        self.startButton.titleLabel?.textColor = .white
        self.startButton.backgroundColor = .blue
        self.startButton.layer.cornerRadius = 20
        self.startButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mainVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        
        mainVC.modalPresentationStyle = .overFullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        
        self.present(mainVC, animated: true, completion: nil)
    }
}
