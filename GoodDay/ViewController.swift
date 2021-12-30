//
//  ViewController.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let backBarButtonItem = UIBarButtonItem(title: "GOOD DAY", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        //self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "NanumSquareL", size: 18)!], for: .normal)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }


}

