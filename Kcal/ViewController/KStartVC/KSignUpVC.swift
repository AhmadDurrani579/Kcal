//
//  KSignUpVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class KSignUpVC: UIViewController {
    
    @IBOutlet var imgeOfUser: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    var presenter: RegistrationPresenter?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFullName.setLeftPaddingPoints(10)
        txtEmailAddress.setLeftPaddingPoints(10)
        txtPhoneNum.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
        txtConfirmPass.setLeftPaddingPoints(10)

        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(KSignUpVC.imageTappedForDp(img:)))
        imgeOfUser.isUserInteractionEnabled = true
        imgeOfUser.addGestureRecognizer(tapGestureRecognizerforDp)
        presenter = RegistrationPresenter(delegate: self)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) {[weak self] (orignal, edited) in
            
            self!.imgeOfUser.image = orignal
            let cgFloat: CGFloat = self!.imgeOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self!.imgeOfUser, radius: CGFloat(someFloat))
            self!.cover_image = orignal
            
        }
        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.KLoginViewController) as? KLoginVC
//        self.navigationController?.pushViewController(vc!, animated: true)
        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KLoginViewController)

    }
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        self.presenter?.registerValidation(fullName: txtFullName.text! , email: txtEmailAddress.text! , phone: txtPhoneNum.text! , password: txtPassword.text!, confrimPasswrod: txtConfirmPass.text! )
        
    }


  
}

extension KSignUpVC: RegistrationDelegate{
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){
        
        let params =      [ kEmail                     :  txtEmailAddress.text!  ,
                            kPassword                  :  txtPassword.text! ,
                            KFullName                  :  txtFullName.text! ,
                            kConfirmPassword           :  txtConfirmPass.text! ,
                            KPhoneNum                  :  txtPhoneNum.text! ,
                            kDeviceType                :  KDeviceType ,
                            kLatitude                  :  "\(DEVICE_LAT)",
                            kLongitude                 :  "\(DEVICE_LONG)" ,
            
            ] as [String : Any]
        self.showAnimation()
        
        if imgeOfUser.image == nil {
            imgeOfUser.image = UIImage(named: "upload_photo")
        }
        WebServiceManager.multiPartImageWithOutHeader(params: params as Dictionary<String, AnyObject> , serviceName: SIGNUP, imageParam:KImageParam, imgFileName: KImageFileName, serviceType: "Sign Up", profileImage: imgeOfUser.image  , cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: {[weak self] (response) in
            self!.dismissLoadingView()
            
            let responseObj = response as! UserResponse
            if responseObj.status == true {
                
                UserDefaults.standard.set(responseObj.data?.token , forKey: "user_token")
                
                let vc = self!.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.KVerifyAccountVC) as? GHVerifyAccountVC
                vc?.isForgotOrSignUp = false
//                self!.navigationController?.pushViewController(vc!, animated: true)
                self!.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KVerifyAccountVC)
                
            }
            else
            {
                self!.showAlert(title: KMessageTitle, message: responseObj.message!, controller: self)
            }
            
        }) { [weak self](error) in
            self!.dismissLoadingView()
            
            
        }
        
    }
    func registrationDidFailed(message: String){
        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}
