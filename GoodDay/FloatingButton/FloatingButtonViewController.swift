//
//  FloatingButtonViewController.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/02.
//

import UIKit
import Lottie


protocol DelegateFloatingButtonViewController: AnyObject {
    func passBoolValue(isShowFloating: Bool)
}

class FloatingButtonViewController: UIViewController {

    let animationView = AnimationView(name: "30344-hamburger-close-animation")
    
    weak var delegate: DelegateFloatingButtonViewController?
    
    let homeImg = UIImage(systemName: "house.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    
    let missionImg = UIImage(systemName: "target", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    
    let diaryImg = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    
    let myPageImg = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var missionButton: UIButton!
    @IBOutlet weak var diaryButton: UIButton!
    @IBOutlet weak var myPageButton: UIButton!
    
    @IBOutlet weak var homeButtonCenterY: NSLayoutConstraint!
    @IBOutlet weak var missionButtonCenterY: NSLayoutConstraint!
    @IBOutlet weak var diaryButtonCenterY: NSLayoutConstraint!
    @IBOutlet weak var myPageButtonCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var homeLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var missionLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var diaryLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var myPageLabelCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var homeLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var missionLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var diaryLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var myPageLabelCenterX: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimationView()
        initializeFloatingButtons()
        configureButtons()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            
            
            self.homeButtonCenterY.constant = 60
            self.missionButtonCenterY.constant = 120
            self.diaryButtonCenterY.constant = 180
            self.myPageButtonCenterY.constant = 240
            
            
            self.homeLabelCenterY.constant = -60
            self.missionLabelCenterY.constant = 120
            self.diaryLabelCenterY.constant = 180
            self.myPageLabelCenterY.constant = 240
            
            self.homeLabelCenterX.constant = 40
            self.missionLabelCenterX.constant = -47
            self.diaryLabelCenterX.constant = -55
            self.myPageLabelCenterX.constant = -70
            
            
            self.view.layoutIfNeeded() // 화면 갱신
        
            
            
        } completion: { (completion) in
            
        }
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
        
        animationView.play()
        animationView.animationSpeed = 5
    
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer){
        
        UIView.animate(withDuration: 0.019, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            
            self.homeButtonCenterY.constant = 0
            self.missionButtonCenterY.constant = 0
            self.diaryButtonCenterY.constant = 0
            self.myPageButtonCenterY.constant = 0
            
            self.homeLabelCenterY.constant = 0
            self.missionLabelCenterY.constant = 0
            self.diaryLabelCenterY.constant = 0
            self.myPageLabelCenterY.constant = 0
            
            self.homeLabelCenterX.constant = 0
            self.missionLabelCenterX.constant = 0
            self.diaryLabelCenterX.constant = 0
            self.myPageLabelCenterX.constant = 0
            
           
            
            self.view.layoutIfNeeded() // 화면 갱신
            
            
            
            
        } completion: { (completion) in
            
            
      
            // 애니메이션이 끝나는 시점
            self.dismiss(animated: false, completion: nil)
        }
        
        delegate?.passBoolValue(isShowFloating: false)

    }
    
    func initializeFloatingButtons() {
        self.homeButtonCenterY.constant = 0
        self.missionButtonCenterY.constant = 0
        self.diaryButtonCenterY.constant = 0
        self.myPageButtonCenterY.constant = 0
        
        self.homeLabelCenterY.constant = 0
        self.missionLabelCenterY.constant = 0
        self.diaryLabelCenterY.constant = 0
        self.myPageLabelCenterY.constant = 0
        
        self.homeLabelCenterX.constant = 0
        self.missionLabelCenterX.constant = 0
        self.diaryLabelCenterX.constant = 0
        self.myPageLabelCenterX.constant = 0
        
        self.blurView.alpha = 0.6
        
    }
    
    
    func configureButtons(){
        homeButton.setImage(homeImg, for: .normal)
        missionButton.setImage(missionImg, for: .normal)
        diaryButton.setImage(diaryImg, for: .normal)
        myPageButton.setImage(myPageImg, for: .normal)
        
        homeButton.tintColor = .black
        missionButton.tintColor = .black
        diaryButton.tintColor = .black
        myPageButton.tintColor = .black
        
        homeButton.layer.cornerRadius = homeButton.bounds.height / 2
        homeButton.layer.shadowColor = UIColor.gray.cgColor
        homeButton.layer.shadowOpacity = 1
        homeButton.layer.shadowOffset = CGSize.zero
        homeButton.layer.shadowRadius = 5
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        
        missionButton.layer.cornerRadius = missionButton.bounds.height / 2
        missionButton.layer.shadowColor = UIColor.gray.cgColor
        missionButton.layer.shadowOpacity = 1
        missionButton.layer.shadowOffset = CGSize.zero
        missionButton.layer.shadowRadius = 5
        missionButton.translatesAutoresizingMaskIntoConstraints = false
        missionButton.addTarget(self, action: #selector(tapMissionButton(_:)), for: .touchUpInside)

        
        diaryButton.layer.cornerRadius = diaryButton.bounds.height / 2
        diaryButton.layer.shadowColor = UIColor.gray.cgColor
        diaryButton.layer.shadowOpacity = 1
        diaryButton.layer.shadowOffset = CGSize.zero
        diaryButton.layer.shadowRadius = 5
        diaryButton.translatesAutoresizingMaskIntoConstraints = false
        
        myPageButton.layer.cornerRadius = myPageButton.bounds.height / 2
        myPageButton.layer.shadowColor = UIColor.gray.cgColor
        myPageButton.layer.shadowOpacity = 1
        myPageButton.layer.shadowOffset = CGSize.zero
        myPageButton.layer.shadowRadius = 5
        myPageButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @IBAction func tapMissionButton(_ sender: UIButton) {
        
        let GDMissionPerDayDetailVC = GDMissionPerDayDetailViewController(nibName: "GDMissionPerDayDetail", bundle: nil)

        GDMissionPerDayDetailVC.modalPresentationStyle = .overFullScreen
        GDMissionPerDayDetailVC.modalTransitionStyle = .crossDissolve
        
        self.present(GDMissionPerDayDetailVC, animated: true, completion: nil)
    }
    


}
