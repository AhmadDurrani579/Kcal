//
//  GSForgotPasswordVC.swift
//  GARAGE SALE
//
//  Created by Ahmed Durrani on 24/01/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class GSForgotPasswordVC: UIViewController {
    @IBOutlet var viewOfPop: UIView!

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet weak var btnOk_Pressed : UIButton!
    var presenter : RegistrationPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegistrationPresenter(delegate: self)
        txtEmail.setLeftPaddingPoints(10)
        viewOfPop.isHidden = true
        btnOk_Pressed.layer.shadowOpacity = 0.5
        btnOk_Pressed.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnOk_Pressed.layer.shadowRadius = 5.0
        btnOk_Pressed.layer.shadowColor = UIColor(red: 102/255.0 , green: 114/255.0 , blue: 228/255.0 , alpha: 1.0).cgColor
        

    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendCode_Pressed(_ sender: UIButton) {
        self.presenter?.forgotPasswordValidation(email: txtEmail.text!)
    }
    
    @IBAction func btnOk_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.KVerifyAccountVC) as? GHVerifyAccountVC
        vc?.email = self.txtEmail.text!
        vc?.isForgotOrSignUp = true
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    

   

}

extension GSForgotPasswordVC: RegistrationDelegate{
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    func registrationDidSucceed(){
        let forgotParam = [ kEmail        : txtEmail.text!
                          ] as [String : Any]
        showAnimation()
        WebServiceManager.postWithOutHeader(params:forgotParam as Dictionary<String, AnyObject> , serviceName: RESET_PASSWORD, isLoaderShow: true , serviceType: "Forgot", modelType: UserResponse.self, success: {[weak self] (response) in
            self!.dismissLoadingView()
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                self!.viewOfPop.isHidden = false
            } else {
                self!.showAlert(title: KMessageTitle, message: responseObj.message! , controller: self)
            }

        }, fail: { (error) in
            self.dismissLoadingView()
        }, showHUD: true)

    }
    func registrationDidFailed(message: String){
        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}
