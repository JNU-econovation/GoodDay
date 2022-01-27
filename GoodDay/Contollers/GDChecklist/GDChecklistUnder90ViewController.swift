//
//  GDChecklistUnder90.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/26.
//

import UIKit

class GDChecklistUnder90:UIViewController {
    
    @IBOutlet weak var resultContent: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultContent.textAlignment = .center
        resultButton.layer.cornerRadius = 16.5
        resultButton.addTarget(self, action: #selector(tapTitleButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapTitleButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }

        mainVC.modalPresentationStyle = .overFullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        
        self.present(mainVC, animated: true, completion: nil)
    }
}
