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
        
        detailView.addSubview(toDayTextLabel(gap: labelsGap))
        detailView.addSubview(toDayMissionLabel(text: "하루 세끼 챙겨먹기", gap: labelsGap))
        detailView.addSubview(toDayMissionSubLabel(text: "이별한 사람들은 밥을 잘 안 먹더라고요.\n이번 기회에 시간 내서 밥을 먹어보아요!", gap: labelsGap))
        detailView.addSubview(changingMissionButton(gap: labelsGap))

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
        toDayMissionSubLabel.numberOfLines = 2
        
        let stringSize = FontUtils().getFontSize(font: toDayMissionSubLabel.font, text: text)
        toDayMissionSubLabel.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: gap * 7 - 16.5 + 51, width: stringSize.width, height: 35)
        
        return toDayMissionSubLabel
    }
    
    func changingMissionButton(gap:CGFloat) -> UIButton {
        let changingMissionButton = UIButton()
        changingMissionButton.setTitle("다른 미션으로 바꾸기", for: .normal)
        changingMissionButton.setTitleColor(.black, for: .normal)
        changingMissionButton.titleLabel?.font = UIFont(name: "NanumSquareOTFL", size: 14)
        
        let stringSize = FontUtils().getFontSize(font: UIFont(name: "NanumSquareOTFL", size: 14)!, text: "다른 미션으로 바꾸기")
        changingMissionButton.frame = CGRect(x: (screenSizeWidth - stringSize.width)/2, y: gap * 9 - 10 + 86, width: stringSize.width, height: 20)

        changingMissionButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        
        return changingMissionButton
    }
}
