//
//  NameSettingViewController.swift
//  GoodDay
//
//  Created by myungsun on 2021/12/31.
//

import UIKit

class NameSettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNameTextField()
        configureNextButton()
        
    }

    func configureNameTextField(){
        self.nameTextField.borderStyle = .none
        self.nameTextField.font = UIFont(name: self.nameTextField.font!.fontName, size: 22)
        self.nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        
        
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField){
        self.validateNextButton()
        
    }
    
    func makeBottomBorder(borderColor: UIColor){
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.nameTextField.frame.size.height, width: self.nameTextField.frame.width - 30 , height: 1)
        border.backgroundColor = borderColor.cgColor
        
        self.nameTextField.layer.addSublayer(border)
    }
    
    
    
    func configureNextButton() {
        
        // 글자 색 변경
        validateNextButton()
        self.nextButton.layer.cornerRadius = 13
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextButton.widthAnchor.constraint(equalToConstant: 330).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        
        
    }
    
    // 다음 버튼 활성화 여부를 체크해주는 메서드
    private func validateNextButton() {
        
        self.nextButton.isEnabled = !(self.nameTextField.text?.isEmpty ?? true) && (self.nameTextField.text?.count ?? 0 >= 2) && (self.nameTextField.text?.count ?? 0 <= 8)
        
        
        
        // 버튼이 활성화 되어 있는 경우
        if self.nextButton.isEnabled {
            // 버튼 글자 색 변경
            self.nextButton.titleLabel?.textColor = .white
            self.nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            self.nextButton.backgroundColor = UIColor(rgb: 0x0015FF)
            self.warningLabel.textColor = UIColor(rgb: 0x0015FF)
            self.warningLabel.text = "사용 가능한 멋진 닉네임입니다."
            self.warningLabel.font = UIFont.systemFont(ofSize: 14)
            self.makeBottomBorder(borderColor: UIColor(rgb: 0x0015FF))
           
            
        }else { // 버튼이 비활성화 되어 있는 경우
            
            self.warningLabel.text = "2글자에서 8글자 사이로 닉네임을 입력해주세요."
            self.warningLabel.font = UIFont.systemFont(ofSize: 14)
            
            self.nextButton.backgroundColor = UIColor(rgb: 0xCACACA)
            
            if ((self.nameTextField.text?.isEmpty) ?? true){
                self.makeBottomBorder(borderColor: UIColor(rgb: 0xCACACA))
                self.warningLabel.textColor = UIColor(rgb: 0xCACACA)
            }else {
                self.makeBottomBorder(borderColor: .red)
                self.warningLabel.textColor = .red
            }

            
            
        }
        
    }
    
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        let MbtiSettingVC = MbtiSettingViewController(nibName: "MbtiSettingViewController", bundle: nil)
        let userName = self.nameTextField.text
        
        MbtiSettingVC.nickName = userName
        MbtiSettingVC.modalPresentationStyle = .overFullScreen
        MbtiSettingVC.modalTransitionStyle = .crossDissolve
        
        self.present(MbtiSettingVC, animated: true, completion: nil)
        
    }
    
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 키보드를 내린다.
        self.view.endEditing(true)
    }
    
}
