//
//  File.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import Lottie
import Firebase
import grpc

class GDMissionPerDayDetailViewController: UIViewController, ProtocolData {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: GDMissionData?
    var docRef: DocumentReference!
    
    var detailView: UIView!
    var missionIndex = -1
    var curDay = -1
    
    @IBAction func onTapButton(_ sender: AnyObject) {
        let button = sender as! UIButton
        if button.tag == 20 {
            if missionIndex != (mission?.count ?? 0) - 1 {
                missionIndex += 1
            } else {
                missionIndex = 0
            }
            print("update index \(missionIndex)")
            detailView.subviews.forEach{$0.removeFromSuperview()}
            detailView = makeDetails(detailView: detailView)
            detailView.setNeedsDisplay()
            detailView.layoutIfNeeded()
            missionPerDayData!.weeks[curWeek! - 1].days[curDay - 1].missionId = missionIndex
            
            //mbti별로 처리 해야하는 구문 작성해야함.
            
            do {
                docRef?.setData(try missionPerDayData!.toDictionary()!)
            } catch {
                print("error 다른 미션 바꾸기 : not changed")
            }
        }
        print("Button was tapped. \(button.titleLabel?.text ?? "")")
    }
    
    @IBAction func onTapBackButton(_ sender: UIButton) {
        sender.showAnimation {
            let notificationName = Notification.Name("sendBoolData")
            
            let boolDic = ["isShowFloating" : false]
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
 
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onTapMissionWeekButton(_ sender: UIButton) {
        let GDMissionPerDayWeeksVC = GDMissionPerDayWeekViewController(nibName: "GDMissionPerDayWeeks", bundle: nil)

        GDMissionPerDayWeeksVC.modalPresentationStyle = .overFullScreen
        GDMissionPerDayWeeksVC.modalTransitionStyle = .crossDissolve
        
        GDMissionPerDayWeeksVC.missionPerDayData = missionPerDayData
        GDMissionPerDayWeeksVC.delegate = self
        
        self.present(GDMissionPerDayWeeksVC, animated: true, completion: nil)
    }
    
    func protocolData(dataSent: Int) {
        curWeek = dataSent
        curDay = -1
        missionIndex = -1
    
        contentView.subviews.forEach{$0.removeFromSuperview()}
        
        collectionView = self.getPeekingCollectionView(screenSizeWidth: screenSizeWidth, contentViewHeight: contentViewHeight, collectionView: collectionView)
        collectionView.reloadData()
        contentView.addSubview(self.getCollectionViewBackgroundImage(collectionView: collectionView))
        contentView.addSubview(collectionView)
        contentView.addSubview(self.getDetailView(screenSizeWidth: screenSizeWidth, contentViewHeight: contentViewHeight))
        contentView.addSubview(self.getweekButton(text: "WEEK \(String(describing: curWeek!))",originButton: weekButton))
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeheight = UIScreen.main.bounds.height
    var contentViewHeight: CGFloat = 0.0
    
    let pickerData = ["DAY 1", "DAY 2", "DAY 3", "DAY 4", "DAY 5", "DAY 6"]
    var mission: [Mission]?
    var missionPerDayData: MissionPerDay?
    var curWeek: Int?
    
    var behavior: MSCollectionViewPeekingBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = GDMissionData.shared
        mission = model?.getMissionData()
                
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: screenSizeWidth * 0.119)
        
        // content height
        contentViewHeight = contentView.frame.height
        
        docRef = model?.db.collection("missionPerDay").document((UserDefaults.standard.string(forKey: "userUid"))!)
        docRef?.getDocument { [self] (document, error) in
            //print(UserDefaults.standard.string(forKey: "mbti"))
            if let document = document, document.exists {
                let data = document.data()
                do {
                    let json = try JSONSerialization.data(withJSONObject: data!, options: [])
                    self.missionPerDayData = try JSONDecoder().decode(MissionPerDay.self, from: json)
                                        
                    let beginDate = UserDefaults.standard.object(forKey: "beginDay") as! Date
                    let curDay = Calendar.current.dateComponents([.day], from: beginDate, to: Date()).day! + 1

                    if curDay != (missionPerDayData?.weeks[(curWeek ?? 1) - 1].days.count) ?? -1 {
                        for i in 1...(curDay + 1) {
                            if i % 7 != 0 {
                                let tmpDayId = i % 7
                                let tmpWeekId = Int(i / 7) + 1
                                
                                if missionPerDayData!.weeks.count < tmpWeekId {
                                    missionPerDayData!.weeks.append(MissionWeek.init(id: tmpWeekId, days: []))
                                }

                                if missionPerDayData!.weeks[tmpWeekId - 1].days.count < tmpDayId {
                                    missionPerDayData!.weeks[tmpWeekId - 1].days.append(MissionDay.init(id: tmpDayId, missionId: Int.random(in: 0..<(mission?.count ?? 1)), isSuccess: 0))
                                }
                                
                                docRef?.setData(try missionPerDayData!.toDictionary()!)
                            }
                        }
                    }
                    
                    curWeek = missionPerDayData?.weeks.count

                    // add components
                    collectionView = self.getPeekingCollectionView(screenSizeWidth: screenSizeWidth, contentViewHeight: contentViewHeight, collectionView: collectionView)
                    contentView.addSubview(self.getCollectionViewBackgroundImage(collectionView: collectionView))
                    contentView.addSubview(collectionView)
                    contentView.addSubview(self.getDetailView(screenSizeWidth: screenSizeWidth, contentViewHeight: contentViewHeight))
                    
                    contentView.addSubview(self.getweekButton(text: "WEEK \(String(describing: curWeek!))",originButton: weekButton))
                } catch {
                    print("getMissionPerDay(): error")
                    // 안되면 초기화
                    // docRef?.updateData(["weeks": [["id": 1, "days": [["id": 1,"isSuccess": 0, "missionId": 0]]]]])
                }
            } else {
                print("Document does not exist")
            }
        }
                
        backButton.addTarget(self, action: #selector(onTapBackButton(_:)), for: .touchUpInside)
    }
    
    func getPeekingCollectionView(screenSizeWidth: CGFloat, contentViewHeight: CGFloat, collectionView: UICollectionView ) -> UICollectionView{
        collectionView.configureForPeekingBehavior(behavior: behavior)
        
        collectionView.backgroundColor = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = CGRect(x: 0, y: 0, width: screenSizeWidth, height: contentViewHeight / 2)
                
        return collectionView
    }
    
    func getCollectionViewBackgroundImage(collectionView: UICollectionView) -> UIImageView {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "MissionPerDayBackground")
        backgroundImageView.frame = CGRect(x: 0, y: contentViewHeight / 4 - 46, width: screenSizeWidth, height: 92)

        backgroundImageView.layer.zPosition = -1
        return backgroundImageView
    }
    
    func getweekButton(text: String, originButton: UIButton) -> UIButton {
        let weekButton = originButton
        originButton.subviews.forEach{$0.removeFromSuperview()}
        
        let weekLable = UILabel()
        weekLable.text = text
        weekLable.textColor = .black
        weekLable.font = UIFont(name: "NanumGothicOTF", size: 24)
        weekLable.sizeToFit()

        let stringSize = FontUtils().getFontSize(font: weekLable.font, text: text)
        weekButton.frame = CGRect(x: (screenSizeWidth - stringSize.width) / 2, y: (contentViewHeight / 2 - screenSizeWidth * 0.6) / 4  - 20, width: stringSize.width, height: 40)
        weekButton.addTarget(self, action: #selector(onTapMissionWeekButton(_:)), for: .touchUpInside)
        weekButton.addSubview(weekLable)

        return weekButton
    }
    
    func getDetailView(screenSizeWidth: CGFloat, contentViewHeight: CGFloat) -> UIView {
        detailView = UIView()

        detailView.frame = CGRect(x:0, y: contentViewHeight/2, width: screenSizeWidth, height: contentViewHeight)
        detailView.layer.shadowOpacity = 0.3
        detailView.layer.shadowOffset = CGSize(width: 0, height: -3)
        detailView.layer.shadowRadius = 5
        detailView.backgroundColor = .white
        
        detailView = makeDetails(detailView: detailView)
        
        return detailView
    }
}
