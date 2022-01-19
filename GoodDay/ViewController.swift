//
//  ViewController.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import Lottie
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController {

    var nickname: String?
    var firstMbti: String?
    var secondMbti: String?
    var thirdMbti: String?
    var fourthMbti: String?
    var wakeUpTime: Date?
    var sleepTime: Date?
    var userUid: String?
    let db = Firestore.firestore()
    var user: User?
    
    @IBOutlet weak var userNameLabel: UILabel!
    var isShowFloating: Bool = true
    let animationView = AnimationView(name: "30344-hamburger-close-animation")
    
    @IBOutlet weak var famousSayingView: UIView!
    @IBOutlet weak var famousSayingLabel: UILabel!
    @IBOutlet weak var famousSayingMentionerLabel: UILabel!
    
    @IBOutlet weak var missionView: UIView!
    @IBOutlet weak var missionDayLabel: UILabel!
    @IBOutlet weak var missionTitleLabel: UILabel!
    @IBOutlet weak var missionFirstTagLabel: UILabel!
    @IBOutlet weak var missionSecondTagLabel: UILabel!
    @IBOutlet weak var missionNextButton: UIButton!
    
    let rightArrowImg = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userUid = UserDefaults.standard.string(forKey: "userUid")
        
        configureUserNameLabel()
        configureAnimationView()
        configureMissionView()
        configureFamousSayingView()
        configureNotificationCenter()
    }

    
    func configureUserNameLabel(){
        
        self.nickname = UserDefaults.standard.string(forKey: "userName")
        
        self.userNameLabel.text = (self.nickname ?? "") + "님,"
        
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
    func configureFamousSayingView(){
        self.famousSayingView.layer.cornerRadius = 13
        self.famousSayingView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.famousSayingView.layer.shadowOpacity = 0.25
    }
    
    func configureMissionView(){
        self.missionView.layer.cornerRadius = 13
        self.missionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.missionView.layer.shadowOpacity = 0.25
        configureMissionButton()
    }
    
    private func configureMissionButton(){
        self.missionNextButton.setImage(rightArrowImg, for: .normal)
        self.missionNextButton.tintColor = .white
    }
    
    func configureNotificationCenter(){
        let notificationName = Notification.Name("sendBoolData")
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendBoolData), name: notificationName, object: nil)
        
    }
    
    @objc private func sendBoolData(notification: Notification){
        self.isShowFloating = notification.userInfo?["isShowFloating"] as? Bool ?? false
        
        if !self.isShowFloating {
            animationView.play(fromFrame: animationView.animation?.endFrame, toFrame: animationView.animation!.startFrame)
            self.isShowFloating = true
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

extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}


