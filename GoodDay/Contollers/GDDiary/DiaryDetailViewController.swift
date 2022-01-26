//
//  DiaryDetailViewController.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/18.
//

import UIKit

protocol DiaryDetailViewControllerDelegate: AnyObject {
    func passDiaryData(date: String, title: String, contents: String)
    func passModifiedDiaryData(date: String, title: String, contents: String)
    func deleteDiaryData(date: String)
}

class DiaryDetailViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var diaryDateLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var finishButton: UIButton!
    
    var diaryEditorMode: DiaryEditorMode?
    var diaryDate: String?
    let contentsTextViewPlaceHolder = "내용을 입력하세요."
    var delegate: DiaryDetailViewControllerDelegate?
    var diaryTitleStr: String?
    var diaryContentsStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewSettings()
    }

    func initializeViewSettings(){
        configureDiaryDateLabel()
        configureDeleteButton()
        configurePointView()
        configureTitleTextField()
        configureContentsView()
        configureFinishButton()
        configureModifiedDiaryData()
        validateInputField()
        
    }
    
    private func configureModifiedDiaryData(){
        if diaryEditorMode == .edit {
            self.titleTextField.text = self.diaryTitleStr
            self.contentsTextView.text = self.diaryContentsStr
        }
    }
    
    private func configureDiaryDateLabel(){
        self.diaryDateLabel.text = self.diaryDate
    }
    
    private func configureDeleteButton(){
        if diaryEditorMode == .new {
            self.deleteButton.layer.isHidden = true
        }else if diaryEditorMode == .edit {
            self.deleteButton.layer.isHidden = false
        }
    }
    
    private func configureTitleTextField(){
        self.titleTextField.layer.borderWidth = 1.0
        self.titleTextField.layer.borderColor = UIColor(rgb: 0xD2D2D2).cgColor
        self.titleTextField.layer.cornerRadius = 7
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.titleTextField.frame.height))
        self.titleTextField.leftView = leftPadding
        self.titleTextField.leftViewMode = UITextField.ViewMode.always
        
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    private func configureContentsView(){
        self.contentsTextView.layer.borderWidth = 1.0
        self.contentsTextView.layer.borderColor = UIColor(rgb: 0xD2D2D2).cgColor
        self.contentsTextView.layer.cornerRadius = 7
        self.contentsTextView.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        self.contentsTextView.font = .systemFont(ofSize: 15)
        
        if diaryEditorMode == .new {
            self.contentsTextView.text = "내용을 입력하세요."
            self.contentsTextView.textColor = UIColor(rgb: 0xD2D2D2)
        }
        self.contentsTextView.delegate = self
    }
    
    private func configurePointView(){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.pointView.bounds
        
        let colors: [CGColor] = [
            UIColor(rgb: 0x0015FF).cgColor,
            UIColor(rgb: 0xAEB5FF).cgColor]
        
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = self.pointView.frame.width / 2
        
        self.pointView.layer.addSublayer(gradientLayer)
        self.pointView.layer.cornerRadius = pointView.frame.width / 2
    }
    
    private func configureFinishButton(){
        self.finishButton.setTitle("완료", for: .normal)
        self.finishButton.setTitleColor(.white, for: .normal)
        self.finishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.finishButton.titleLabel?.textColor = .white
        
        
    }
    private func validateInputField() {
        self.finishButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text.isEmpty) && (self.contentsTextView.text != contentsTextViewPlaceHolder)
        
        if self.finishButton.isEnabled {
            self.finishButton.titleLabel?.textColor = .white
            self.finishButton.backgroundColor = UIColor(rgb: 0x0015FF)
            self.finishButton.layer.cornerRadius = 7
            self.finishButton.translatesAutoresizingMaskIntoConstraints = false
            self.finishButton.widthAnchor.constraint(equalToConstant: 348).isActive = true
            self.finishButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }else {
            self.finishButton.backgroundColor = UIColor(rgb: 0xCACACA)
            self.finishButton.layer.cornerRadius = 7
            self.finishButton.translatesAutoresizingMaskIntoConstraints = false
            self.finishButton.widthAnchor.constraint(equalToConstant: 348).isActive = true
            self.finishButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    // 유저가 화면을 터치하면 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 빈 화면을 누를 때마다 키보드나 데이트피커가 사라지게 된다.
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        sender.showAnimation {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "삭제", message: "정말로 해당 날짜의 일기를 삭제하시겠습니까?", preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "삭제", style: .default) { _ in
            
            // 일기를 삭제하는 로직
            self.delegate?.deleteDiaryData(date: self.diaryDateLabel.text ?? "")
            
            self.dismiss(animated: true, completion: nil)
            
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapFinishButton(_ sender: UIButton) {
        if diaryEditorMode == .new {
            guard let date = self.diaryDateLabel.text else { return }
            guard let title = self.titleTextField.text else { return }
            guard let contents = self.contentsTextView.text else { return }
            
            delegate?.passDiaryData(date: date, title: title, contents: contents) ?? nil
            
            self.dismiss(animated: true, completion: nil)
        }else if diaryEditorMode == .edit {
            guard let date = self.diaryDateLabel.text else { return }
            guard let title = self.titleTextField.text else { return }
            guard let contents = self.contentsTextView.text else { return }
            
            delegate?.passModifiedDiaryData(date: date, title: title, contents: contents)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
}

extension DiaryDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == contentsTextViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = contentsTextViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}

