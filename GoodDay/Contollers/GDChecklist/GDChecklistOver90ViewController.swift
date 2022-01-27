//
//  GDChecklistUnder90.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/26.
//

import UIKit

class GDChecklistOver90:UIViewController {
    @IBOutlet weak var resultContent: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultContent.textAlignment = .center
        resultButton.layer.cornerRadius = 16.5
        resultButton.addTarget(self, action: #selector(tapTitleButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapTitleButton(_ sender: UIButton) {
        let GDCeremony = GDCeremony(nibName: "GDCeremony", bundle: nil)

        GDCeremony.modalPresentationStyle = .overFullScreen
        GDCeremony.modalTransitionStyle = .crossDissolve
        
        self.present(GDCeremony, animated: true, completion: nil)
    }
}
