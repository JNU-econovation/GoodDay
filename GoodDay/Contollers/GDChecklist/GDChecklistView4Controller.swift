//
//  GDChecklistViewController.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/24.
//

import UIKit

class GDChecklist4ViewController: UIViewController {
    @IBOutlet weak var slider10: UISlider!
    @IBOutlet weak var slider11: UISlider!
    @IBOutlet weak var slider12: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    
    var q10: Int?
    var q11: Int?
    var q12: Int?
    var qs: [Int] = []
    var isDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSliderRect()
        nextButton.layer.cornerRadius = 13
        nextButton.setTitleColor(.white, for: .disabled)
        nextButton.addTarget(self, action: #selector(tapNextButton(_:)), for: .touchUpInside)
    }
    
    func settingSliderRect() {
        slider10.tag = 10
        slider11.tag = 11
        slider12.tag = 12
        
        addTick(slider: slider10, selfView: self.view)
        addTick(slider: slider11, selfView: self.view)
        addTick(slider: slider12, selfView: self.view)

        slider10.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider10.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider10.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
        
        slider11.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider11.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider11.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)

        slider12.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider12.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider12.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
    }
    
    @IBAction func moveSliderThumb(sender: UISlider) {
        // 색 바꾸기
        let value = sender.value
        let redColor = 255 - Int((value - 1) / 4 * 106)
        let greenColor = 255 - Int((value - 1) / 4 * 98)
        sender.thumbTintColor = UIColor(red: redColor, green: greenColor, blue: 255)
        let senderValue = sender.value
        
        switch senderValue {
        case 1..<1.385965:
            qSender(value: 1, idx:sender.tag)
            sender.setValue(1, animated: true)
        case 1.385965..<2.452631:
            qSender(value: 2, idx:sender.tag)
            sender.setValue(1.891228, animated: true)
        case 2.452631..<3.561404:
            qSender(value: 3, idx:sender.tag)
            sender.setValue(3, animated: true)
        case 3.561404..<4.656140:
            qSender(value: 4, idx:sender.tag)
            sender.setValue(4.066667, animated: true)
        case _:
            qSender(value: 5, idx:sender.tag)
            sender.setValue(5, animated: true)
        }
        
        if ((q10 ?? 0) * (q11 ?? 0) * (q12 ?? 0)) != 0 {
            nextButton.backgroundColor = ColorUtils().hexStringToUIColor(hex: "#0015FF", alpha: 1)
            isDone = true
        }
    }

    func qSender(value: Int, idx: Int){
        switch idx {
        case 10:
            q10 = value
        case 11:
            q11 = value
        case 12:
            q12 = value
        default:
            return
        }
    }

    func addTick(slider: UISlider, selfView: UIView) {
        let sliderWidth = UIScreen.main.bounds.width - 78
        let sliderFrame = slider.frame
        
        let sliderTickBigImageView = UIImageView()
        sliderTickBigImageView.image = UIImage(named: "sliderTickBig")
        sliderTickBigImageView.frame = CGRect(x: sliderWidth / 2 + 0.5, y: sliderFrame.height / 2 - 5, width: 1, height: 10)
        sliderTickBigImageView.layer.zPosition = -1
        
        let sliderTickSmallLeftImageView = UIImageView()
        sliderTickSmallLeftImageView.image = UIImage(named: "sliderTickSmall")
        sliderTickSmallLeftImageView.frame = CGRect(x: sliderWidth / 4 + 0.5, y: sliderFrame.height / 2 - 3, width: 1, height: 6)
        sliderTickSmallLeftImageView.layer.zPosition = -1

        let sliderTickSmallRightImageView = UIImageView()
        sliderTickSmallRightImageView.image = UIImage(named: "sliderTickSmall")
        sliderTickSmallRightImageView.frame = CGRect(x: sliderWidth / 4 * 3 + 0.5, y: sliderFrame.height / 2 - 3, width: 1, height: 6)
        sliderTickSmallRightImageView.layer.zPosition = -1

        slider.addSubview(sliderTickBigImageView)
        slider.addSubview(sliderTickSmallLeftImageView)
        slider.addSubview(sliderTickSmallRightImageView)
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
//        let GDChecklist2VC = GDChecklist2ViewController(nibName: "GDChecklist2", bundle: nil)
//
        qs.append(q10!)
        qs.append(q11!)
        qs.append(q12!)
        print(qs)
//        
//        GDChecklist2VC.qs = qs
//
//        GDChecklist2VC.modalPresentationStyle = .overFullScreen
//        GDChecklist2VC.modalTransitionStyle = .crossDissolve
//        
//        self.present(GDChecklist2VC, animated: true, completion: nil)
    }
}
