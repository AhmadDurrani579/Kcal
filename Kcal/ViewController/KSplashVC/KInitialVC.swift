//
//  KInitialVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class KInitialVC: UIViewController {
    
    @IBOutlet var imgOfSignUp: UIImageView!
    @IBOutlet var imgOfLogin: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(KInitialVC.signUp_Pressed(img:)))
        imgOfSignUp.isUserInteractionEnabled = true
        imgOfSignUp.addGestureRecognizer(tapGestureRecognizerforDp)
        
        
        let tapGestureRecognizerforDp1 = UITapGestureRecognizer(target:self, action:#selector(KInitialVC.login_Pressed(img:)))
        imgOfLogin.isUserInteractionEnabled = true
        imgOfLogin.addGestureRecognizer(tapGestureRecognizerforDp1)
        
    }

    @objc func signUp_Pressed(img: AnyObject)
    {
        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KSELECTSIGNUPPROCESS)

    }
    
    @objc func login_Pressed(img: AnyObject)
    {
        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KLoginViewController)

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
