//
//  GDChecklistViewController.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/24.
//

import UIKit

class GDChecklist1ViewController: UIViewController {
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var q1: Int?
    var q2: Int?
    var q3: Int?
    var qs = [Int](repeating: 0, count: 12) 
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
        slider1.tag = 1
        slider2.tag = 2
        slider3.tag = 3
        
        addTick(slider: slider1, selfView: self.view)
        addTick(slider: slider2, selfView: self.view)
        addTick(slider: slider3, selfView: self.view)

        slider1.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider1.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider1.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
        
        slider2.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider2.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider2.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)

        slider3.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider3.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider3.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
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
        
        if ((q1 ?? 0) * (q2 ?? 0) * (q3 ?? 0)) != 0 {
            nextButton.backgroundColor = ColorUtils().hexStringToUIColor(hex: "#0015FF", alpha: 1)
            isDone = true
        }
    }

    func qSender(value: Int, idx: Int){
        switch idx {
        case 1:
            q1 = value
        case 2:
            q2 = value
        case 3:
            q3 = value
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
        let GDChecklist2VC = GDChecklist2ViewController(nibName: "GDChecklist2", bundle: nil)
        
        qs[0] = q1!
        qs[1] = q2!
        qs[2] = q3!
        GDChecklist2VC.qs = qs

        GDChecklist2VC.modalPresentationStyle = .overFullScreen
        GDChecklist2VC.modalTransitionStyle = .crossDissolve
        
        self.present(GDChecklist2VC, animated: true, completion: nil)
    }
    
    @IBAction func tapPrevButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
