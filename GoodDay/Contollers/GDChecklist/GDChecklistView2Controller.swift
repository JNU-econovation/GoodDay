//
//  GDChecklistViewController.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/24.
//

import UIKit

class GDChecklist2ViewController: UIViewController {
    @IBOutlet weak var slider4: UISlider!
    @IBOutlet weak var slider5: UISlider!
    @IBOutlet weak var slider6: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!

    var q4: Int?
    var q5: Int?
    var q6: Int?
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
        slider4.tag = 4
        slider5.tag = 5
        slider6.tag = 6
        
        addTick(slider: slider4, selfView: self.view)
        addTick(slider: slider5, selfView: self.view)
        addTick(slider: slider6, selfView: self.view)

        slider4.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider4.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider4.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
        
        slider5.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider5.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider5.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)

        slider6.setMaximumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider6.setMinimumTrackImage(UIImage(named: "sliderTrack"), for: .normal)
        slider6.addTarget(self, action: #selector(moveSliderThumb(sender:)), for: .valueChanged)
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
        
        if ((q4 ?? 0) * (q5 ?? 0) * (q6 ?? 0)) != 0 {
            nextButton.backgroundColor = ColorUtils().hexStringToUIColor(hex: "#0015FF", alpha: 1)
            isDone = true
        }
    }

    func qSender(value: Int, idx: Int){
        switch idx {
        case 4:
            q4 = value
        case 5:
            q5 = value
        case 6:
            q6 = value
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
        let GDChecklist3VC = GDChecklist3ViewController(nibName: "GDChecklist3", bundle: nil)
        
        qs[3] = q4!
        qs[4] = q5!
        qs[5] = q6!
        GDChecklist3VC.qs = qs

        GDChecklist3VC.modalPresentationStyle = .overFullScreen
        GDChecklist3VC.modalTransitionStyle = .crossDissolve
        
        self.present(GDChecklist3VC, animated: true, completion: nil)
    }
    
    @IBAction func tapPrevButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
