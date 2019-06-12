//
//  GHChangePasswordVC.swift
//  GARAGE SALE
//
//  Created by Ahmed Durrani on 24/01/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class GHChangePasswordVC: UIViewController {
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRetypePassword : UITextField!
    var presenter: RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegistrationPresenter(delegate: self)
        txtPassword.setLeftPaddingPoints(10)
        txtRetypePassword.setLeftPaddingPoints(10)

    }
    
    @IBAction func btnChangePassword_Pressed(_ sender: UIButton) {
        self.presenter?.validationOnChangePassword(password: txtPassword.text!, confirmPass: txtRetypePassword.text!)
        
    }
}

extension GHChangePasswordVC: RegistrationDelegate{
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){

        let params =      [ kConfirmPassword                     :  txtRetypePassword.text!  ,
                            KNewPassword                         :  txtPassword.text!
                          ] as [String : Any]
        self.showAnimation()
        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: CHANGE_PASSWORd, isLoaderShow: true, serviceType: "change PAssword", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            self!.dismissLoadingView()
            if responseObj.status == true {
                self!.showAlertViewWithTitle(title: KMessageTitle, message: responseObj.message! , dismissCompletion: {
                    self?.navigationController?.popToRootViewController(animated: true)
                })
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)

        
    }
    func registrationDidFailed(message: String){
        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}
