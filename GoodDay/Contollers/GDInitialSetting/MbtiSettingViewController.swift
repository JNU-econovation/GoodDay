//
//  MbtiSettingViewController.swift
//  GoodDay
//
//  Created by myungsun on 2021/12/31.
//

import UIKit


enum MbtiPosition {
    case first
    case second
    case third
    case fourth
}

class MbtiSettingViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var firstMbtiTextField: UITextField!
    @IBOutlet weak var secondMbtiTextField: UITextField!
    @IBOutlet weak var thirdMbtiTextField: UITextField!
    @IBOutlet weak var fourthMbtiTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var nickName: String?
    var mbtiPosition: MbtiPosition?
    var firstMbtiPicker: UIPickerView?
    var secondMbtiPicker: UIPickerView?
    var thirdMbtiPicker: UIPickerView?
    var fourthMbtiPicker: UIPickerView?
    let firstMbtiList = ["E", "I"]
    let secondMbtiList = ["S", "N"]
    let thirdMbtiList = ["T", "F"]
    let fourthMbtiList = ["J", "P"]
    let mbtiListSize: Int = 2
    var finishButton: UIBarButtonItem!
    var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMbtiPicker()
        configureFinishButton()
        configureToolbar()
        configureBackButton()
        configureMbtiTextFields()
        configureNextButton()
    }


    
    func configureMbtiTextFields(){
        
        self.firstMbtiTextField.addTarget(self, action: #selector(beginFirstTextField(_:)), for: .editingDidBegin)
        
        self.secondMbtiTextField.addTarget(self, action: #selector(beginSecondTextField(_:)), for: .editingDidBegin)
        
        
        self.thirdMbtiTextField.addTarget(self, action: #selector(beginThirdTextField(_:)), for: .editingDidBegin)
        
        
        self.fourthMbtiTextField.addTarget(self, action: #selector(beginFourthTextField(_:)), for: .editingDidBegin)

        
        
        self.firstMbtiTextField.borderStyle = .none
        self.secondMbtiTextField.borderStyle = .none
        self.thirdMbtiTextField.borderStyle = .none
        self.fourthMbtiTextField.borderStyle = .none
        
        self.firstMbtiTextField.font = UIFont(name: self.firstMbtiTextField.font!.fontName, size: 24)
        
        self.secondMbtiTextField.font = UIFont(name: self.secondMbtiTextField.font!.fontName, size: 24)
        
        self.thirdMbtiTextField.font = UIFont(name: self.thirdMbtiTextField.font!.fontName, size: 24)
        
        self.fourthMbtiTextField.font = UIFont(name: self.fourthMbtiTextField.font!.fontName, size: 24)
        
        
        
        
        let firstBorder = CALayer()
        let secondBorder = CALayer()
        let thirdBorder = CALayer()
        let fourthBorder = CALayer()
        
        firstBorder.frame = CGRect(x: 0, y: self.firstMbtiTextField.frame.size.height - 1, width: self.firstMbtiTextField.frame.width, height: 1)
        
        secondBorder.frame = CGRect(x: 0, y: self.secondMbtiTextField.frame.size.height - 1, width: self.secondMbtiTextField.frame.width, height: 1)
        
        thirdBorder.frame = CGRect(x: 0, y: self.thirdMbtiTextField.frame.size.height - 1, width: self.thirdMbtiTextField.frame.width, height: 1)
        
        fourthBorder.frame = CGRect(x: 0, y: self.fourthMbtiTextField.frame.size.height - 1, width: self.fourthMbtiTextField.frame.width, height: 1)
        
        firstBorder.backgroundColor = UIColor.black.cgColor
        
        secondBorder.backgroundColor = UIColor.black.cgColor
        
        thirdBorder.backgroundColor = UIColor.black.cgColor
        
        fourthBorder.backgroundColor = UIColor.black.cgColor
        
        self.firstMbtiTextField.layer.addSublayer(firstBorder)
        self.secondMbtiTextField.layer.addSublayer(secondBorder)
        self.thirdMbtiTextField.layer.addSublayer(thirdBorder)
        self.fourthMbtiTextField.layer.addSublayer(fourthBorder)
        
        self.firstMbtiTextField.textAlignment = .center
        self.secondMbtiTextField.textAlignment = .center
        self.thirdMbtiTextField.textAlignment = .center
        self.fourthMbtiTextField.textAlignment = .center
        
        
        
        
    }
    
    @objc private func beginFirstTextField(_ textField: UITextField){
        mbtiPosition = .first
        self.firstMbtiTextField.inputView = self.firstMbtiPicker
        self.firstMbtiTextField.inputAccessoryView = self.toolbar
    }
    
    @objc private func beginSecondTextField(_ textField: UITextField){
        mbtiPosition = .second
        self.secondMbtiTextField.inputView = self.secondMbtiPicker
        self.secondMbtiTextField.inputAccessoryView = self.toolbar
    }
    
    @objc private func beginThirdTextField(_ textField: UITextField){
        mbtiPosition = .third
        self.thirdMbtiTextField.inputView = self.thirdMbtiPicker
        self.thirdMbtiTextField.inputAccessoryView = self.toolbar
    }
    
    @objc private func beginFourthTextField(_ textField: UITextField){
        mbtiPosition = .fourth
        self.fourthMbtiTextField.inputView = self.fourthMbtiPicker
        self.fourthMbtiTextField.inputAccessoryView = self.toolbar
    }
    
    

    
    func configureNextButton(){
        self.validateNextButton()
        
        self.nextButton.layer.cornerRadius = 13

        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextButton.widthAnchor.constraint(equalToConstant: 330).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func configureMbtiPicker(){
        
        self.firstMbtiPicker = UIPickerView()
        self.secondMbtiPicker = UIPickerView()
        self.thirdMbtiPicker = UIPickerView()
        self.fourthMbtiPicker = UIPickerView()


        self.firstMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        self.secondMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        self.thirdMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        self.fourthMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        self.firstMbtiPicker?.delegate = self
        self.firstMbtiPicker?.dataSource = self
        
        self.secondMbtiPicker?.delegate = self
        self.secondMbtiPicker?.dataSource = self
        
        self.thirdMbtiPicker?.delegate = self
        self.thirdMbtiPicker?.dataSource = self
        
        self.fourthMbtiPicker?.delegate = self
        self.fourthMbtiPicker?.dataSource = self

    }
    
    func configureFinishButton() {
        self.finishButton = UIBarButtonItem()
        self.finishButton.title = "완료"
        self.finishButton.target = self
        self.finishButton.action = #selector(closeMbtiPicker)
    }
    @objc func closeMbtiPicker(){
        self.validateNextButton()
        self.view.endEditing(true)
    }
    func configureToolbar(){
        self.toolbar = UIToolbar()
        self.toolbar.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.toolbar.tintColor = UIColor(rgb: 0x0015FF)
        self.toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbar.setItems([flexSpace, self.finishButton], animated: true)
        
    }
    
    func configureBackButton() {
        self.backButton.tintColor = .black
    }
    
    // 다음 버튼 활성화 여부를 체크해주는 메서드
    private func validateNextButton() {
        
        self.nextButton.isEnabled = !(self.firstMbtiTextField.text?.isEmpty ?? true) && !(self.secondMbtiTextField.text?.isEmpty ?? true) && !(self.thirdMbtiTextField.text?.isEmpty ?? true) && !(self.fourthMbtiTextField.text?.isEmpty ?? true)
        
        // 버튼이 활성화 되어 있는 경우
        if self.nextButton.isEnabled {
            // 버튼 글자 색 변경
            self.nextButton.titleLabel?.textColor = .white
            self.nextButton.backgroundColor = UIColor(rgb: 0x0015FF)
            
           
            
        }else { // 버튼이 비활성화 되어 있는 경우
            self.nextButton.backgroundColor = UIColor(rgb: 0xCACACA)
            
        }
       
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        let timeSettingVC = TimeSettingViewController(nibName: "TimeSettingViewController", bundle: nil)
        
        timeSettingVC.nickname = self.nickName
        timeSettingVC.firstMbti = self.firstMbtiTextField.text
        timeSettingVC.secondMbti = self.secondMbtiTextField.text
        timeSettingVC.thirdMbti = self.thirdMbtiTextField.text
        timeSettingVC.fourthMbti = self.fourthMbtiTextField.text
        
        
        timeSettingVC.modalPresentationStyle = .overFullScreen
        timeSettingVC.modalTransitionStyle = .crossDissolve
        
        self.present(timeSettingVC, animated: true, completion: nil)
        
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.validateNextButton()
        // 키보드를 내린다.
        self.view.endEditing(true)
        
    }
}

extension MbtiSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {


    // 한 뷰에 picker view가 몇 개 담겨져 있는지 반환(여러 picker뷰가 존재하면 가로로 정렬)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return mbtiListSize

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var pickerTitle: String? = nil
        switch mbtiPosition {
        case .first:
            if row == 0 {
                pickerTitle = firstMbtiList[row] + " (외향형)"
            }else{
                pickerTitle = firstMbtiList[row] + " (내향형)"
            }
        case .second:
            if row == 0 {
                pickerTitle = secondMbtiList[row] + " (감각형)"
            }else {
                pickerTitle = secondMbtiList[row] + " (직관형)"
            }
        case .third:
            if row == 0 {
                pickerTitle = thirdMbtiList[row] + " (사고형)"
            }else {
                pickerTitle = thirdMbtiList[row] + " (감정형)"
            }
        case .fourth:
            if row == 0 {
                pickerTitle = fourthMbtiList[row] + " (판단형)"
            }else {
                pickerTitle = fourthMbtiList[row] + " (인식형)"
            }
        default:
            break
            
        }
        return pickerTitle


    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch mbtiPosition {
        case .first:
            self.firstMbtiTextField.text = self.firstMbtiList[row]
        case .second:
            self.secondMbtiTextField.text = self.secondMbtiList[row]
        case .third:
            self.thirdMbtiTextField.text = self.thirdMbtiList[row]
        case .fourth:
            self.fourthMbtiTextField.text = self.fourthMbtiList[row]
        default:
            break
            
        }
    }

}
