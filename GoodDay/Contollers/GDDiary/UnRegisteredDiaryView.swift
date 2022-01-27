//
//  UnRegisteredDiaryView.swift
//  GoodDay
//
//  Created by myungsun on 2022/01/18.
//

import UIKit

class UnRegisteredDiaryView: UIView {

   
    var diaryDateString: String?
    
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
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022. 01. 06"
        return label
        
    }()
    
    let missionLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "맛있는 거 먹기"
        
        
        return label
    }()
    
    let registerButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
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
        self.addSubview(registerButton)
        
        constraintCustomView()
        
        
    }
    
    func constraintCustomView() {
        NSLayoutConstraint.activate([
            
            pointView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            pointView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45),
            dateLabel.leadingAnchor.constraint(equalTo: pointView.trailingAnchor, constant: 33),
            dateLabel.centerYAnchor.constraint(equalTo: pointView.centerYAnchor),
            
            missionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            missionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 85),
            
            
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -46)
            
            
            
        ])
    }

}
