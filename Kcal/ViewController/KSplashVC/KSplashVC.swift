//
//  KSplashVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class KSplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            
            let user_token = UserDefaults.standard.string(forKey: "user_token")
//            self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.kMainInitialVC)

            if user_token == nil {
                self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.kMainInitialVC)

            } else {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "KMainItemVC")
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                UIApplication.shared.keyWindow?.rootViewController = nav

            }
            
        })    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
