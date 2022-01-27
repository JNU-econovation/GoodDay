//
//  RegisteredDiaryView.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/18.
//

import UIKit

class RegisteredDiaryView: UIView {

    let pointView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let gradientLayer = CAGradientLayer()
        let colors: [CGColor] = [
            UIColor(rgb: 0x0015FF).cgColor,
            UIColor(rgb: 0xAEB5FF).cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = view.frame.width / 2
        view.layer.addSublayer(gradientLayer)
        view.layer.cornerRadius = view.frame.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareOTFB", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022. 01. 07"
        
        return label
        
    }()
    
    let missionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareOTFR", size: 16)
        label.textColor = UIColor(rgb: 0x323232)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "맛있는 거 먹기"
        label.numberOfLines = 1
        
        return label
    }()
    
    let diaryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareOTFB", size: 24)

        label.text = "오늘은 치팅데이!!!!!!ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let diaryContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareOTFL", size: 12)
        label.textColor = UIColor(rgb: 0xAAAAAA)
        label.text = "오늘은 치팅데이였다. 의식을 잃고 치킨,피자,보쌈을 흡입하였다. 눈 뜨고 보니 치킨, 피자, 보쌈은 모두 없어져 있었다... 다 먹고보니 정말 후회가 된다."
        label.numberOfLines = 2
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(rgb: 0x0015FF)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(pointView)
        self.addSubview(dateLabel)
        self.addSubview(missionLabel)
        self.addSubview(diaryTitleLabel)
        self.addSubview(diaryContentLabel)
        self.addSubview(seeMoreButton)
        constraintCustomView()
    }
    
    func constraintCustomView() {
        NSLayoutConstraint.activate([
            pointView.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            pointView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 34),
            dateLabel.leadingAnchor.constraint(equalTo: pointView.trailingAnchor, constant: 33),
            dateLabel.centerYAnchor.constraint(equalTo: pointView.centerYAnchor),
            
            missionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            missionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 84),
            
            diaryTitleLabel.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 24),
            diaryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            diaryTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            diaryContentLabel.topAnchor.constraint(equalTo: diaryTitleLabel.bottomAnchor, constant: 15),
            diaryContentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            diaryContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            seeMoreButton.widthAnchor.constraint(equalToConstant: 300),
            seeMoreButton.heightAnchor.constraint(equalToConstant: 60),
            seeMoreButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            seeMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            seeMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -46)
        ])
    }
}
