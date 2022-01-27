//
//  GDChecklistViewController.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/24.
//

import UIKit

class GDChecklist3ViewController: UIViewController {
    @IBOutlet weak var slider7: UISlider!
    @IBOutlet weak var slider8: UISlider!
    @IBOutlet weak var slider9: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var q7: Int?
    var q8: Int?
    var q9: Int?
    var qs = [Int](repeating: 0, count: 13)
    var isDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSliderRect()
        nextButton.layer.cornerRadius = 13
        nextButton.setTitleColor(.white, for: .disabled)
        nextButton.addTarget(self, action: #selector(tapNextButton(_:)), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(tapPrevButton(_:)), for: .touchUpInside)
    }
    
    func settingSliderRect() {
        slider7.tag = 7
        slider8.tag = 8
        slider9.tag = 9
        
        addTick(slider: slider7, selfView: self.view)
        addTick(slider: slider8, selfView: self.view)
        addTick(slider: slider9, selfView: self.view)

        slider7.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider7.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider7.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
        
        slider8.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider8.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider8.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)

        slider9.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider9.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider9.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
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
        
        if ((q7 ?? 0) * (q8 ?? 0) * (q9 ?? 0)) != 0 {
            nextButton.backgroundColor = ColorUtils().hexStringToUIColor(hex: "#0015FF", alpha: 1)
            isDone = true
        }
    }

    func qSender(value: Int, idx: Int){
        switch idx {
        case 7:
            q7 = value
        case 8:
            q8 = value
        case 9:
            q9 = value
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
        if !isDone {
            return
        }
        let GDChecklist4VC = GDChecklist4ViewController(nibName: "GDChecklist4", bundle: nil)

        qs[6] = q7!
        qs[7] = q8!
        qs[8] = q9!
        GDChecklist4VC.qs = qs

        GDChecklist4VC.modalPresentationStyle = .overFullScreen
        GDChecklist4VC.modalTransitionStyle = .crossDissolve
        
        self.present(GDChecklist4VC, animated: true, completion: nil)
    }
    
    @IBAction func tapPrevButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
