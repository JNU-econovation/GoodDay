//
//  ViewController.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
<<<<<<< Updated upstream
import Lottie
=======
import FirebaseFirestore
>>>>>>> Stashed changes

class ViewController: UIViewController {
    let db = Firestore.firestore()

    var nickname: String?
    var firstMbti: String?
    var secondMbti: String?
    var thirdMbti: String?
    var fourthMbti: String?
    var wakeUpTime: Date?
    var sleepTime: Date?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var isShowFloating: Bool = true
    let animationView = AnimationView(name: "30344-hamburger-close-animation")
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< Updated upstream
        configureUserNameLabel()
        configureAnimationView()
=======
        // Do any additional setup after loading the view.
        
        let backBarButtonItem = UIBarButtonItem(title: "GOOD DAY", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        //self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "NanumSquareL", size: 18)!], for: .normal)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
>>>>>>> Stashed changes
    }

    
    func configureUserNameLabel(){
        self.userNameLabel.text = (self.nickname ?? "")  + "님,"
    }
    
    func configureAnimationView(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        animationView.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -27).isActive = true
        animationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        animationView.heightAnchor.constraint(equalToConstant:32).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        animationView.contentMode = .scaleAspectFit
    
    }
    @objc private func handleTap(sender: UITapGestureRecognizer){
        
        if isShowFloating {
            animationView.play()
            animationView.animationSpeed = 5
            
            let floatingButtonVC = FloatingButtonViewController(nibName: "FloatingButtonViewController", bundle: nil)
            
            floatingButtonVC.modalPresentationStyle = .overCurrentContext
            
            floatingButtonVC.delegate = self
            
            self.present(floatingButtonVC, animated: false, completion: nil)
    
            
        }
        
    }

}

extension ViewController: DelegateFloatingButtonViewController {
    
    func passBoolValue(isShowFloating: Bool) {
        self.isShowFloating = isShowFloating
        
        if !self.isShowFloating {
            animationView.play(fromFrame: animationView.animation?.endFrame, toFrame: animationView.animation!.startFrame)
            self.isShowFloating = true
        }
        
        
    }
}


