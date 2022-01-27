//
//  GDChecklistUnder90.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/26.
//

import UIKit

class GDChecklistOver90ViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    let checkImg = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 23,weight: .bold))
    let xmarkImg = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14,weight: .bold))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(tapCloseButton(_:)), for: .touchUpInside)
    }
    
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mainVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        
        mainVC.modalPresentationStyle = .overFullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        
        self.present(mainVC, animated: true, completion: nil)
    }
}
