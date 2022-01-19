//
//  DiaryCalendarViewController.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/18.
//

import UIKit
import FSCalendar
import FirebaseFirestore
import FirebaseFirestoreSwift

class DiaryCalendarViewController: UIViewController {

    
    let unRegisteredDiaryView: UnRegisteredDiaryView = {
        
        let view = UnRegisteredDiaryView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 38
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.25
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let registeredDiaryView: RegisteredDiaryView = {
        
        let view = RegisteredDiaryView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 38
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.25
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    let calendarView: FSCalendar = {
        
        let calendar = FSCalendar()
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = UIColor(rgb: 0x8A8A8A)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        calendar.appearance.titlePlaceholderColor = UIColor(rgb: 0xE3E3E3)
        calendar.appearance.headerDateFormat = "MMMM  yyyy"
        calendar.locale = Locale(identifier: "en_US")
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        calendar.appearance.titleTodayColor = UIColor(rgb: 0x0015FF)
        calendar.appearance.todayColor = .white
        calendar.appearance.selectionColor = UIColor(rgb: 0x0015FF)
        calendar.appearance.eventDefaultColor = UIColor(rgb: 0x0015FF)
        calendar.appearance.eventSelectionColor = .white
        calendar.appearance.borderRadius = 1
        calendar.appearance.eventOffset = .init(x: -0.3, y: -11)
        calendar.appearance.headerTitleOffset = .init(x: -75, y: -10)
        
        calendar.appearance.headerTitleAlignment = .left
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return calendar
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
        
    }()
    let todayDate = Date()
    let db = Firestore.firestore()
    let userUid = UserDefaults.standard.string(forKey: "userUid")
    var todayDateStr: String?
    var isRegisteredDiary: Bool = false
    var selectedDateStr: String?
    var registeredDiaryDateList = [String]()
    var diaryList = [Diary]()
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendarViewLayout()
        fetchDiaryData()
//        configureTodayDate()
//        configureDiaryView()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.calendarView.reloadData()
    }
    
    private func configureTodayDate() {
        self.todayDateStr = self.dateFormatter.string(from: self.todayDate)
        validateIsRegisteredDiary(date: self.todayDateStr ?? "")
        unRegisteredDiaryView.dateLabel.text = self.todayDateStr
        registeredDiaryView.dateLabel.text = self.todayDateStr
    }
    
    func configureCalendarViewLayout() {
        
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.view.addSubview(calendarView)
        calendarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        calendarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        calendarView.widthAnchor.constraint(equalToConstant: 390).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        
        
        
    }
    
    func validateIsRegisteredDiary(date: String){
        // 매개변수로 받은 date에 일기가 등록되어 있으면 isRegistered = true
        // 등록되어 있지 않으면 isRegistered = false
        
        if registeredDiaryDateList.contains(date) {
            self.isRegisteredDiary = true
        }else {
            self.isRegisteredDiary = false
        }
    }
    
    func configureDiaryView() {
        // 오늘 날짜를 위에서 가져왔으니 해당 날짜에 등로된 일기가 있는지 DB에서 검사해야 함. - 그에 따라서 isRegisteredDiary의 값도 설정해줘야함.
        
        // 해당 날짜에 다이어리가 등록되지 않은 경우
        if !isRegisteredDiary {
            setUpUnregisteredDiaryView()
            unRegisteredDiaryView.isHidden = false
            registeredDiaryView.isHidden = true
            
        }else{
            setUpRegisteredDiaryView()
            registeredDiaryView.isHidden = false
            unRegisteredDiaryView.isHidden = true
        }
        
    }
    
    private func setUpUnregisteredDiaryView(){
        
        unRegisteredDiaryView.registerButton.addTarget(self, action: #selector(tapRegisterButton), for: .touchUpInside)
        
        self.view.addSubview(unRegisteredDiaryView)
        NSLayoutConstraint.activate([
            
            unRegisteredDiaryView.widthAnchor.constraint(equalToConstant: 390),
            unRegisteredDiaryView.heightAnchor.constraint(equalToConstant: 250),
            unRegisteredDiaryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            unRegisteredDiaryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            unRegisteredDiaryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            
            
        ])
        
        
        
    }
    
    @objc private func tapRegisterButton(){
        let diaryDetailVC = DiaryDetailViewController(nibName: "DiaryDetailViewController", bundle: nil)
        
        diaryDetailVC.delegate = self
        diaryDetailVC.diaryEditorMode = .new
        diaryDetailVC.diaryDate = self.unRegisteredDiaryView.dateLabel.text
        diaryDetailVC.modalTransitionStyle = .crossDissolve
        diaryDetailVC.modalPresentationStyle = .overFullScreen
        self.present(diaryDetailVC, animated: true, completion: nil)
        
        
    }
    
    
    
    private func setUpRegisteredDiaryView() {
        
        self.registeredDiaryView.seeMoreButton.addTarget(self, action: #selector(tapSeeMoreButton), for: .touchUpInside)
        
        self.view.addSubview(registeredDiaryView)
        
        NSLayoutConstraint.activate([
            
            registeredDiaryView.widthAnchor.constraint(equalToConstant: 390),
            registeredDiaryView.heightAnchor.constraint(equalToConstant: 300),
            registeredDiaryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            registeredDiaryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            registeredDiaryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            
            
        ])
        
    }
    @objc private func tapSeeMoreButton(){
        let diaryDetailVC = DiaryDetailViewController(nibName: "DiaryDetailViewController", bundle: nil)
        
        
        guard let date = self.registeredDiaryView.dateLabel.text else { return }
        
        guard let title = self.registeredDiaryView.diaryTitleLabel.text else { return }
        
        guard let contents = self.registeredDiaryView.diaryContentLabel.text else { return }
        
        diaryDetailVC.diaryDate = date
        diaryDetailVC.diaryTitleStr = title
        diaryDetailVC.diaryContentsStr = contents
        
        
        diaryDetailVC.delegate = self
        diaryDetailVC.diaryEditorMode = .edit
        diaryDetailVC.diaryDate = self.registeredDiaryView.dateLabel.text
        diaryDetailVC.modalTransitionStyle = .crossDissolve
        diaryDetailVC.modalPresentationStyle = .overFullScreen
        self.present(diaryDetailVC, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        
        
        sender.showAnimation {
            let notificationName = Notification.Name("sendBoolData")
            
            let boolDic = ["isShowFloating" : false]
            
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
            
            
            
            
            self.dismiss(animated: true, completion: nil)
        }
       
        
        
    }
    func fetchDiaryData() {
//        self.diaryList = [Diary]()
//        self.registeredDiaryDateList = [String]()
        self.db.collection("diarys").document(self.userUid!).getDocument { (document, error) in
            if let document = document {
                
                if let diary = (document["diaryList"] as? [[String: String]]) {
                    
                    for (idx, _) in diary.enumerated() {
                        let title = diary[idx]["title"]! as String
                        let contents = diary[idx]["contents"]! as String
                        let date = diary[idx]["date"]! as String
                        
                        
                        let diary = Diary(title: title, contents: contents, date: date)
                        
                        print("title is \(title)")
                        print("contents is \(contents)")
                        print("date is \(date)")
                        self.diaryList.append(diary)
                        self.registeredDiaryDateList.append(date)
                        self.calendarView.reloadData()
                        
                    }
                    
                    
                }
                self.configureTodayDate()
                self.configureDiaryView()
                for diary in self.diaryList {
                    if diary.date == self.todayDateStr {
                        self.registeredDiaryView.dateLabel.text = diary.date
                        self.registeredDiaryView.diaryTitleLabel.text = diary.title
                        self.registeredDiaryView.diaryContentLabel.text = diary.contents
                    }
                }
                
                
            }
        }
        
        
    }
    



}


extension DiaryCalendarViewController: FSCalendarDelegate,FSCalendarDataSource{
    

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        selectedDateStr = self.dateFormatter.string(from: date)
        
        validateIsRegisteredDiary(date: selectedDateStr ?? "")
        
        // 선택된 날짜에 일기장이 등록되지 않은 경우
        if !self.isRegisteredDiary {
            setUpUnregisteredDiaryView()
            unRegisteredDiaryView.dateLabel.text = selectedDateStr
            registeredDiaryView.isHidden = true
            unRegisteredDiaryView.isHidden = false
            
        }else {
            setUpRegisteredDiaryView()
            registeredDiaryView.dateLabel.text = selectedDateStr
            for diary in diaryList {
                
                if diary.date == selectedDateStr {
                    registeredDiaryView.diaryTitleLabel.text = diary.title
                    registeredDiaryView.diaryContentLabel.text = diary.contents
                    break
                }
            }
            unRegisteredDiaryView.isHidden = true
            registeredDiaryView.isHidden = false
            
        }
        
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        
       
        let dateString = dateFormatter.string(from: date)
        
        if registeredDiaryDateList.contains(dateString) {
            return 1
        }
       
        
//        let datesWithEvent = ["2022.01.07"]
//
//        let formmater = DateFormatter()
//        formmater.dateFormat = "yyyy.MM.dd"
//
//        let dateString = formmater.string(from: date)
//
//        if datesWithEvent.contains(dateString){
//            return 1
//        }
        
        
        return 0
    }
    
    
    
    
    
    
}








extension DiaryCalendarViewController: DiaryDetailViewControllerDelegate {
    
    // 일기장 추가 후 호출되는 메소드
    func passDiaryData(date: String, title: String, contents: String){
        
        let diary = Diary(title: title, contents: contents, date: date)
        
        self.diaryList.append(diary)
        self.registeredDiaryDateList.append(date)
        
        var diaryListItem = [Any]()
        
        do {
            let jsonData = try JSONEncoder().encode(diary)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            diaryListItem.append(jsonObject)
            
        }catch {
            
        }
        
        if self.diaryList.count == 1 {
            let docData: [String: Any] = [
                "diaryList": diaryListItem
            ]
            self.db.collection("diarys").document(self.userUid!).setData(docData) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                }else {
                    print("Docuemnt successfully written!")
                }
            }
            
        }else {
            self.db.collection("diarys").document(self.userUid!).updateData([
                "diaryList": FieldValue.arrayUnion(diaryListItem)
            ])
            
        }
        
        registeredDiaryView.dateLabel.text = date
        registeredDiaryView.diaryTitleLabel.text = title
        registeredDiaryView.diaryContentLabel.text = contents
        
        calendarView.reloadData()
        validateIsRegisteredDiary(date: date)
        configureDiaryView()
        
        
        
    }
    
    // 일기장 수정 후 호출되는 메소드
    func passModifiedDiaryData(date: String, title: String, contents: String) {
    
        for (indexVal,diary) in diaryList.enumerated() {
            if diary.date == date {
                diaryList[indexVal].title = title
                diaryList[indexVal].contents = contents
                
            }
            
        }
        
        var diaryListItem = [Any]()
        
        for diary in self.diaryList {
            do {
                let jsonData = try JSONEncoder().encode(diary)
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                diaryListItem.append(jsonObject)
                
            }catch{
                
            }
        }
        let docData: [String: Any] = [
            "diaryList": diaryListItem
        ]
        
        self.db.collection("diarys").document(self.userUid!).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }else {
                print("Document successfully Update")
            }
            
        }
        registeredDiaryView.dateLabel.text = date
        registeredDiaryView.diaryTitleLabel.text = title
        registeredDiaryView.diaryContentLabel.text = contents
        
    }
    func deleteDiaryData(date: String) {
        
        let deletedDiary: Diary
        for (indexVal, dateStr) in registeredDiaryDateList.enumerated() {
            if dateStr == date {
                registeredDiaryDateList.remove(at: indexVal)
                
                break
            }
            
        }
        
        for (indexVal, diary) in diaryList.enumerated() {
            if diary.date == date {
                
                deletedDiary = diary
                diaryList.remove(at: indexVal)
                
                var diaryListItem = [Any]()
                
                do {
                    let jsonData = try JSONEncoder().encode(deletedDiary)
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    diaryListItem.append(jsonObject)
                }catch {
                }
                
                self.db.collection("diarys").document(self.userUid!).updateData([
                    "diaryList": FieldValue.arrayRemove(diaryListItem)
                ])
                break
            }
        }
        
        
        validateIsRegisteredDiary(date: date)
        configureDiaryView()
        unRegisteredDiaryView.dateLabel.text = date
        calendarView.reloadData()
        
    }
}


