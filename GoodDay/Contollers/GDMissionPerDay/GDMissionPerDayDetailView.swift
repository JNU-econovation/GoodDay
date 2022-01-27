//
//  GDMissionPerDayDetailView.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/31.
//

import UIKit

extension GDMissionPerDayDetailViewController {
    
    
    func makeDetails (detailView: UIView) -> UIView {
        let labelsGap = (contentViewHeight/2 - 106) / 13
        
        if curDay == -1 {
            curDay = missionPerDayData!.weeks[(curWeek ?? 1) - 1].days.count
        }
        if missionIndex == -1 {
            missionIndex = missionPerDayData!.weeks[(curWeek ?? 1) - 1].days[curDay - 1].missionId
        }
        
        detailView.addSubview(toDayTextLabel(gap: labelsGap))
        detailView.addSubview(toDayMissionBackgroundImage(text: mission?[missionIndex].content ?? "", gap: labelsGap))
        detailView.addSubview(toDayMissionLabel(text: mission?[missionIndex].content ?? "", gap: labelsGap))
        detailView.addSubview(toDayMissionSubLabel(text: mission?[missionIndex].detail ?? "", gap: labelsGap))
        if missionPerDayData!.weeks[curWeek! - 1].days[curDay - 1].isSuccess != 1 {
            detailView.addSubview(changingMissionButton(gap: labelsGap))
        }

        return detailView
    }
    
    func toDayTextLabel(gap: CGFloat) -> UILabel {
        // set text and font
        let toDayTextLabel = UILabel()
        toDayTextLabel.text = "오늘의 미션"
        toDayTextLabel.textColor = .black
        toDayTextLabel.font = UIFont(name: "NanumSquareOTFB", size: 18)
        
        // set size
        let stringSize = FontUtils().getFontSize(font: toDayTextLabel.font, text: "오늘의 미션")
        toDayTextLabel.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: 4 * gap - 10, width: stringSize.width, height: 20)
        
        return toDayTextLabel
    }
    
    func toDayMissionLabel(text: String, gap:CGFloat) -> UILabel {
        // set text and font
        let toDayMissionLabel = UILabel()
        toDayMissionLabel.text = text
        toDayMissionLabel.textColor = .black
        toDayMissionLabel.font = UIFont(name: "NanumSquareOTFB", size: 27)
        
        // set size
        let stringSize = FontUtils().getFontSize(font: toDayMissionLabel.font, text: text)
        toDayMissionLabel.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: gap * 6 - 15.5 + 20, width: stringSize.width, height: 31)
        
        return toDayMissionLabel
    }
    
    func toDayMissionSubLabel(text: String, gap:CGFloat) -> UILabel {
        let toDayMissionSubLabel = UILabel()
        toDayMissionSubLabel.text = text
        toDayMissionSubLabel.textColor = ColorUtils().hexStringToUIColor(hex: "#5C5C5C", alpha: 1)
        toDayMissionSubLabel.font = UIFont(name: "NanumSquareOTFL", size: 12)
        toDayMissionSubLabel.textAlignment = .center
        toDayMissionSubLabel.numberOfLines = 2
        
        let stringSize = FontUtils().getFontSize(font: toDayMissionSubLabel.font, text: text)
        toDayMissionSubLabel.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: gap * 7 - 16.5 + 51, width: stringSize.width, height: 35)
        
        return toDayMissionSubLabel
    }
    
    func changingMissionButton(gap:CGFloat) -> UIButton {
        let changingMissionButton = UIButton()
        // string에 효과 넣어서 하는 방법 중 한가지
        let changingTitleAttribute: [NSAttributedString.Key: Any] = [
              .font: UIFont(name: "NanumSquareOTFL", size: 14)!,
              .foregroundColor: UIColor.black,
              .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let chaningTitleString = NSMutableAttributedString(
                string: "다른 미션으로 바꾸기",
                attributes: changingTitleAttribute
        )
        changingMissionButton.setAttributedTitle(chaningTitleString, for: .normal)

        let stringSize = FontUtils().getFontSize(font: UIFont(name: "NanumSquareOTFL", size: 14)!, text: "다른 미션으로 바꾸기")
        changingMissionButton.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: gap * 9 - 10 + 86, width: stringSize.width, height: 20)

        changingMissionButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        changingMissionButton.tag = 20
        
        return changingMissionButton
    }
    
    func toDayMissionBackgroundImage(text: String, gap:CGFloat) -> UIImageView {
        let changingMissionBackgroundImage = UIImageView()
        let backgroundImage = UIImage(named: "MissioinTitleBackground")
        
        changingMissionBackgroundImage.image = backgroundImage
        
        let stringSize = FontUtils().getFontSize(font: UIFont(name: "NanumSquareOTFB", size: 27)!, text: text)
        changingMissionBackgroundImage.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: gap * 6 - 15.5 + 20 + 31 * 0.4, width: stringSize.width, height: 31 * 0.6)
        
        return changingMissionBackgroundImage
    }
}
