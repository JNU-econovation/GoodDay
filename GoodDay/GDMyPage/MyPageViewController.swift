//
//  MyPageViewController.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/23.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class MyPageViewController: UIViewController {

    
    @IBOutlet weak var myPageSubView: UIView!
    @IBOutlet weak var mbtiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wakeUpTimeLabel: UILabel!
    @IBOutlet weak var sleepTimeLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var myPageImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var mbtiStackView: UIStackView!
    @IBOutlet weak var wakeUpTimeStackView: UIStackView!
    @IBOutlet weak var sleepTimeStackView: UIStackView!
    
    @IBOutlet weak var mbtiEditLabel: UILabel!
    @IBOutlet weak var wakeUpTimeEditLabel: UILabel!
    @IBOutlet weak var sleepTimeEditLabel: UILabel!
    
    @IBOutlet weak var mbtiEditButton: UIButton!
    @IBOutlet weak var timeEditButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    let editImage = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
    
    let rightChevronImg = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold))
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
        
    }()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMyPageViews()
        initailizeMyPageData()
        
    }
    
    func initializeMyPageViews(){
        configureEditButton()
        self.mbtiLabel.translatesAutoresizingMaskIntoConstraints = false

        self.myPageSubView.translatesAutoresizingMaskIntoConstraints = false
        self.myPageImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mbtiEditButton.setImage(rightChevronImg, for: .normal)
        self.timeEditButton.setImage(rightChevronImg, for: .normal)
        
        self.mbtiEditButton.layer.isHidden = true
        self.timeEditButton.layer.isHidden = true
        self.mbtiEditButton.alpha = 0
        self.timeEditButton.alpha = 0
        self.mbtiStackView.alpha = 0
        self.lineView.alpha = 0
        self.wakeUpTimeStackView.alpha = 0
        self.sleepTimeStackView.alpha = 0
    }
    
    func initailizeMyPageData(){
        let userDefaults = UserDefaults.standard
        
        self.mbtiLabel.text = userDefaults.string(forKey: "mbti")
        self.nameLabel.text = userDefaults.string(forKey: "userName")! + "님"
        self.wakeUpTimeLabel.text = self.timeFormatter.string(from: userDefaults.object(forKey: "wakeUpTime") as! Date)
        self.sleepTimeLabel.text = self.timeFormatter.string(from: userDefaults.object(forKey: "sleepTime") as! Date)
        
        if userDefaults.string(forKey: "updateTime") == nil {
            self.updateTimeLabel.text = self.timeFormatter.string(from: userDefaults.object(forKey: "beginDay") as! Date)
        }else {
            self.updateTimeLabel.text = userDefaults.string(forKey: "updateTime")
        }
        
        self.mbtiEditLabel.text = userDefaults.string(forKey: "mbti")
        self.wakeUpTimeEditLabel.text = self.timeFormatter.string(from: userDefaults.object(forKey: "wakeUpTime") as! Date)
        self.sleepTimeEditLabel.text = self.timeFormatter.string(from: userDefaults.object(forKey: "sleepTime") as! Date)
        
    }
    
    private func configureEditButton(){
        self.editButton.setImage(editImage, for: .normal)
        self.editButton.layer.cornerRadius = self.editButton.frame.width / 2
        
    }
    
    func animateMyPageViews(){
        self.editButton.layer.isHidden = true
        self.myPageSubView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        self.mbtiLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 142).isActive = true
        self.myPageImageView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        self.myPageImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        self.myPageImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 111).isActive = true
        self.myPageImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -15).isActive = true
    
        self.mbtiStackView.alpha = 1
        self.lineView.alpha = 1
        
        self.mbtiEditButton.layer.isHidden = false
        self.timeEditButton.layer.isHidden = false
        self.mbtiEditButton.alpha = 1
        self.timeEditButton.alpha = 1
        self.wakeUpTimeStackView.alpha = 1
        self.sleepTimeStackView.alpha = 1
        
        self.view.layoutIfNeeded() // 화면 갱신
    }
    
    


    @IBAction func tapEditButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            
            self.animateMyPageViews()
        } completion: { (completion) in
            
        }
    }
    
    
    @IBAction func tapMbtiEditButton(_ sender: UIButton) {
        let mbtiSettingVC = MbtiSettingViewController(nibName: "MbtiSettingViewController", bundle: nil)
        mbtiSettingVC.delegate = self
        mbtiSettingVC.myPageEditorMode = .edit
        mbtiSettingVC.mbti = self.mbtiEditLabel.text
        
        mbtiSettingVC.modalPresentationStyle = .overFullScreen
        mbtiSettingVC.modalTransitionStyle = .crossDissolve
        
        self.present(mbtiSettingVC, animated: true, completion: nil)
        
        
        
        
    }
    
    @IBAction func tapTimeEditButton(_ sender: UIButton) {
        let timeSettingVC = TimeSettingViewController(nibName: "TimeSettingViewController", bundle: nil)
        timeSettingVC.delegate = self
        timeSettingVC.myPageEditorMode = .edit
        timeSettingVC.wakeUpTime = UserDefaults.standard.object(forKey: "wakeUpTime") as? Date
        timeSettingVC.sleepTime = UserDefaults.standard.object(forKey: "sleepTime") as? Date
        
        timeSettingVC.modalPresentationStyle = .overFullScreen
        timeSettingVC.modalTransitionStyle = .crossDissolve
        
        self.present(timeSettingVC, animated: true, completion: nil)
    }
    
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        let notificationName = Notification.Name("sendBoolData")
        
        let boolDic = ["isShowFloating" : false]
        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    


}

extension MyPageViewController: DelegateMbtiSettingViewController, DelegateTimeSettingController {
    
    func passMbtiData(mbti: String) {
        let userDefaults = UserDefaults.standard
        let currentTime = Date()
        let currentUpdateTime = timeFormatter.string(from: currentTime)
        self.mbtiLabel.text = mbti
        self.mbtiEditLabel.text = mbti
        
        self.updateTimeLabel.text = timeFormatter.string(from: currentTime)
        
        userDefaults.set(mbti, forKey: "mbti")
        userDefaults.set(currentUpdateTime, forKey: "updateTime")
        
        self.db.collection("users").document(userDefaults.string(forKey: "userUid")!).updateData([
            "mbti": mbti
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
    }
    
    func passTimeData(wakeUpTime: Date, sleepTime: Date) {
        let userDefaults = UserDefaults.standard
        let currentTime = Date()
        let currentUpdateTime = timeFormatter.string(from: currentTime)
        
        self.wakeUpTimeLabel.text = timeFormatter.string(from: wakeUpTime)
        self.sleepTimeLabel.text = timeFormatter.string(from: sleepTime)
        self.wakeUpTimeEditLabel.text = timeFormatter.string(from: wakeUpTime)
        self.sleepTimeEditLabel.text = timeFormatter.string(from: sleepTime)
        self.updateTimeLabel.text = timeFormatter.string(from: currentTime)
        
        userDefaults.set(wakeUpTime, forKey: "wakeUpTime")
        userDefaults.set(sleepTime, forKey: "sleepTime")
        userDefaults.set(currentUpdateTime, forKey: "updateTime")
        self.db.collection("users").document(userDefaults.string(forKey: "userUid")!).updateData([
            "wakeUpTime": wakeUpTime,
            "sleepTime": sleepTime
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
        
    }
    
}

