//
//  GHVerifyAccountVC.swift
//  GARAGE SALE
//
//  Created by Ahmed Durrani on 24/01/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class GHVerifyAccountVC: UIViewController , UITextFieldDelegate  {
    @IBOutlet var tfOneText: UITextField!
    @IBOutlet var tfTwoTxt: UITextField!
    @IBOutlet var tfThirdTxt: UITextField!
    @IBOutlet var tfFouthTxt: UITextField!
    @IBOutlet var lblSec: UILabel!
    var email : String?
    var isForgotOrSignUp : Bool?
//    @IBOutlet var tfSixthTxt: UITextField!
    var sec: Int = 0
    var clockTime: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sec = 60
        clockTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeTimeText), userInfo: nil, repeats: true)


        // Do any additional setup after loading the view.
    }
    
    @objc func changeTimeText() {
        sec = sec - 1
        lblSec.text = "\(sec)"
        
        if sec == 0 {
            clockTime!.invalidate()
        }
    }

    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerify_Pressed(_ sender: UIButton) {
        
        var codeEnter = tfOneText.text!
        codeEnter    += tfTwoTxt.text!
        codeEnter    += tfThirdTxt.text!
        codeEnter    += tfFouthTxt.text!
        var params = [:] as [String : Any]
        if isForgotOrSignUp == true {

            params =      [ KCODE                     :  codeEnter ,
                            kEmail                    :  email!
                          ] as [String : Any]
//            reset-password-verify
            
            WebServiceManager.postWithOnlyAcceptJson(params:params as Dictionary<String, AnyObject> , serviceName: RESET_PASSWORD_VERIFY , isLoaderShow: true,  serviceType: "Sign Up", modelType: UserResponse.self, success: {[weak self] (response) in
                self!.dismissLoadingView()
                
                let responseObj = response as! UserResponse
                if responseObj.status == true {
                    UserDefaults.standard.set(responseObj.data?.user?.token , forKey: "user_token")
                    self?.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.kCHNAGEPASSWORD)

                } else {
                    
                    self!.showAlert(title: KMessageTitle, message: responseObj.message!, controller: self)
                    
                }
                
                }, fail: { (error) in
                    self.dismissLoadingView()
                    
            }, showHUD: true)
            
            
        } else {
            
            params =      [ KCODE                     :  codeEnter
                ] as [String : Any]
            WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: VERIFY_CODE , isLoaderShow: true,  serviceType: "Sign Up", modelType: UserResponse.self, success: {[weak self] (response) in
                self!.dismissLoadingView()
                
                let responseObj = response as! UserResponse
                
                if responseObj.status == true {
                    UserDefaults.standard.set(responseObj.data?.user?.token , forKey: "user_token")
//                    UserDefaults.standard.set(responseObj.data?.user?.phoneNumber , forKey: "phoneNum")

                    self?.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KPRofileSET)

                } else {
                    
                    self!.showAlert(title: KMessageTitle, message: responseObj.message!, controller: self)
                    
                }
                
                }, fail: { (error) in
                    self.dismissLoadingView()
                    
            }, showHUD: true)
            

        }
        self.showAnimation()
        
//        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: servicURL!, isLoaderShow: true,  serviceType: "Sign Up", modelType: UserResponse.self, success: {[weak self] (response) in
//            self!.dismissLoadingView()
//
//            let responseObj = response as! UserResponse
//
//            if responseObj.status == true {
//
//            } else {
//
//                self.showAlert(title: KMessageTitle, message: responseObj.message!, controller: self)
//
//            }
//
//        }, fail: { (error) in
//            self.dismissLoadingView()
//
//        }, showHUD: true)

//        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KUploadInfoViewController)
//
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.KUploadInfoViewController) as? GSUploadInfo
//        self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func btnResendCode_Pressed(_ sender: UIButton) {

        self.showAnimation()
        let params =      [:] as [String : Any]

        WebServiceManager.post(params: params as Dictionary<String, AnyObject> , serviceName: RESEND_CODE, isLoaderShow: true,  serviceType: "Sign Up", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            let responseObj = response as! UserResponse
            
            if responseObj.status == true {
                self.showAlert(title: KMessageTitle, message: responseObj.message!, controller: self)

            } else {
                
                self.showAlert(title: KMessageTitle, message: responseObj.message!, controller: self)
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            
        }, showHUD: true)

    }
    
    func verifyOrResndCode(isResendCode : Bool) {
        
    }
    
    
    @objc func checkTF() {
        if (tfOneText.text?.count == 1) {
            tfTwoTxt.becomeFirstResponder()
        }
        if (tfTwoTxt.text?.count == 1) {
            tfThirdTxt.becomeFirstResponder()
        }
        if (tfThirdTxt.text?.count == 1) {
            tfFouthTxt.becomeFirstResponder()
        }
        if (tfFouthTxt.text?.count == 1) {
            tfFouthTxt.resignFirstResponder()
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        if textField == tfOneText {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfTwoTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfThirdTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfFouthTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        
        return true
    }

}
