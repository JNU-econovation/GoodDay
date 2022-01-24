//
//  GDChecklistViewController.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/24.
//

import UIKit

class GDChecklistViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class GDChecklistView1: UIView {
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        slider1.minimumTrackTintColor = ColorUtils().hexStringToUIColor(hex: "#CBCBCB", alpha: 1)
        slider1.maximumTrackTintColor = ColorUtils().hexStringToUIColor(hex: "#CBCBCB", alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class GDChecklistView2: UIView {
    @IBOutlet var slider4: UISlider!
    @IBOutlet var slider5: UISlider!
    @IBOutlet var slider6: UISlider!
    @IBOutlet var nextButton: UIButton!
}

class GDChecklistView3: UIView {
    @IBOutlet var slider7: UISlider!
    @IBOutlet var slider8: UISlider!
    @IBOutlet var slider9: UISlider!
    @IBOutlet var nextButton: UIButton!
    
}

class GDChecklistView4: UIView {
    @IBOutlet var slider10: UISlider!
    @IBOutlet var slider11: UISlider!
    @IBOutlet var slider12: UISlider!
    @IBOutlet var nextButton: UIButton!
}
