//
//  KSetAllowAccessVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class KSetAllowAccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnContinue_Pressed(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "KMainItemVC")
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = nav

    }

  

}
