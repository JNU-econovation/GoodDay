//
//  TimeSettingViewController.swift
//  GoodDay
//
//  Created by myungsun on 2021/12/31.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol DelegateTimeSettingController: AnyObject {
    func passTimeData(wakeUpTime: Date, sleepTime: Date)
}

class TimeSettingViewController: UIViewController {

    var nickname: String?
    var firstMbti: String?
    var secondMbti: String?
    var thirdMbti: String?
    var fourthMbti: String?
    var wakeUpTime: Date?
    var sleepTime: Date?
    var wakeUptimePicker: UIDatePicker!
    var sleepTimePicker: UIDatePicker!
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
        
    }()
    var myPageEditorMode: MyPageEditorMode = .new
    var delegate: DelegateTimeSettingController?
    let userUid = UUID().uuidString
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var wakeUpTimeTextField: UITextField!
    @IBOutlet weak var sleepTimeTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTimeTextFields()
        configureWakeUpTimePicker()
        configureSleepTimePicker()
        configureFinishButton()
        editTimeTextFields()
    }
    
 
    func editTimeTextFields(){
        // 마이 페이지에서 기상/취침 시간 수정하는 경우
        if myPageEditorMode == .edit {
            self.wakeUpTimeTextField.text = timeFormatter.string(from: wakeUpTime!)
            self.sleepTimeTextField.text = timeFormatter.string(from: sleepTime!)
            self.validateFinishButton()
        }
    }

    func configureFinishButton(){
        // "완료"버튼 속성 및 오토레이아웃 설정.
        self.validateFinishButton()
        self.finishButton.layer.cornerRadius = 13
        self.finishButton.translatesAutoresizingMaskIntoConstraints = false
        self.finishButton.widthAnchor.constraint(equalToConstant: 330).isActive = true
        self.finishButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    func configureWakeUpTimePicker() {
        // 기상 시간 타임피커 속성 설정.
        self.wakeUptimePicker = UIDatePicker()
        self.wakeUptimePicker.backgroundColor = .blue
        self.wakeUptimePicker.layer.masksToBounds = true
        
        self.wakeUptimePicker.datePickerMode = .time
        self.wakeUptimePicker.preferredDatePickerStyle = .wheels
        
        self.wakeUptimePicker.addTarget(self, action: #selector(DidWakeUpTimePickerValueChange(_:)), for: .valueChanged)
        
        self.wakeUpTimeTextField.inputView = self.wakeUptimePicker
    }
    
    func configureSleepTimePicker(){
        // 취침 시간 타임피커 속성 설정.
        self.sleepTimePicker = UIDatePicker()
        self.sleepTimePicker.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        self.sleepTimePicker.datePickerMode = .time
        self.sleepTimePicker.preferredDatePickerStyle = .wheels
        
        self.sleepTimePicker.addTarget(self, action: #selector(DidSleepTimePickerValueChange(_:)), for: .valueChanged)
        
        self.sleepTimeTextField.inputView = self.sleepTimePicker
    }
    
    
    @objc private func DidWakeUpTimePickerValueChange(_ timePicker: UIDatePicker){
        self.wakeUpTime = self.wakeUptimePicker.date
        self.wakeUpTimeTextField.text = timeFormatter.string(from: self.wakeUptimePicker.date)
        self.wakeUpTimeTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func DidSleepTimePickerValueChange(_ timePicker: UIDatePicker) {
        self.sleepTime = self.sleepTimePicker.date
        self.sleepTimeTextField.text = timeFormatter.string(from: self.sleepTimePicker.date)
        self.wakeUpTimeTextField.sendActions(for: .editingChanged)
    }
    
    func configureTimeTextFields(){
        // 타임 텍스트필드 속성 지정 및 이벤트 리스너 등록.
        self.wakeUpTimeTextField.addTarget(self, action: #selector(DidtextFieldChange(_:)), for: .editingChanged)
        self.sleepTimeTextField.addTarget(self, action: #selector(DidtextFieldChange(_:)), for: .editingChanged)
        
        self.wakeUpTimeTextField.borderStyle = .none
        self.sleepTimeTextField.borderStyle = .none
        
        self.wakeUpTimeTextField.font = UIFont(name: self.wakeUpTimeTextField.font!.fontName, size: 40)
        
        self.sleepTimeTextField.font = UIFont(name: self.sleepTimeTextField.font!.fontName, size: 40)
        
        self.wakeUpTimeTextField.textAlignment = .center
        self.sleepTimeTextField.textAlignment = .center
    }
    @objc private func DidtextFieldChange(_ textField: UITextField){
        self.validateFinishButton()
    }
    
    // 완료 버튼 활성화 여부를 체크해주는 메서드
    private func validateFinishButton() {
        self.finishButton.isEnabled = !(self.wakeUpTimeTextField.text?.isEmpty ?? true) && !(self.sleepTimeTextField.text?.isEmpty ?? true)
        
        // 버튼이 활성화 되어 있는 경우
        if self.finishButton.isEnabled {
            self.finishButton.titleLabel?.textColor = .white
            self.finishButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            self.finishButton.backgroundColor = UIColor(rgb: 0x0015FF)
        }else { // 버튼이 비활성화 되어 있는 경우
            self.finishButton.backgroundColor = UIColor(rgb: 0xCACACA)
        }
    }

    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드를 내린다.
        self.view.endEditing(true)
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tapFinishButton(_ sender: UIButton) {
        // 초기 설정인 경우
        if myPageEditorMode == .new{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let mainVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
            
            mainVC.nickname = self.nickname
            mainVC.userUid = self.userUid
            mainVC.modalPresentationStyle = .overFullScreen
            mainVC.modalTransitionStyle = .crossDissolve
            
            saveUserInfo()
            
            self.present(mainVC, animated: true, completion: nil)
        }else { // 마이 페이지에서 수정하는 경우
            delegate?.passTimeData(wakeUpTime: self.wakeUptimePicker.date, sleepTime: self.sleepTimePicker.date)
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
        
    }
    
    func saveUserInfo(){
        let db = Firestore.firestore()
        let beginDay = Date()
        let mbti = (self.firstMbti ?? "") + (self.secondMbti ?? "") + (self.thirdMbti ?? "")  + (self.fourthMbti ?? "")
        let user = User(name: self.nickname ?? "", mbti: mbti, wakeUpTime: self.wakeUpTime ?? Date(), sleepTime: self.sleepTime ?? Date(), beginDay: beginDay)
        
        UserDefaults.standard.set(true, forKey: "isInitialized")
        UserDefaults.standard.set(self.userUid, forKey: "userUid")
        UserDefaults.standard.set(self.nickname, forKey:"userName")
        UserDefaults.standard.set(beginDay, forKey: "beginDay")
        UserDefaults.standard.set(mbti, forKey:"mbti")
        UserDefaults.standard.set(self.wakeUpTime, forKey: "wakeUpTime")
        UserDefaults.standard.set(self.sleepTime, forKey: "sleepTime")
        
        do {
            try db.collection("users").document(self.userUid).setData(from: user)
            db.collection("missionPerDay").document(self.userUid).setData(["weeks": [["days":[["id": 1, "isSuccess": 0,"missionId": Int.random(in: 0..<44)]], "id": 1]]])
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
}
