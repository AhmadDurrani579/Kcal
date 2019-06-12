//
//  KLoginVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import GoogleSignIn

class KLoginVC: UIViewController , GIDSignInUIDelegate , GIDSignInDelegate  {
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    var presenter: RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
//        txtEmail.text = "ahmaddurranitrg@gmail.com"
//        txtPassword.text = "123456789"
        presenter = RegistrationPresenter(delegate: self)
        
        GIDSignIn.sharedInstance().delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
        self.presenter?.signIn(email: txtEmail.text!, password: txtPassword.text!)
        
    }
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KSignUpSelectionViewController)

        
    }

    
    @IBAction func btnForgotPassword_Pressed(_ sender: UIButton) {
        pushToViewControllerWithStoryboardID(storyboardId:VCIdentifier.kForgotPasswordController)
    }

    @IBAction func btnFacebook_Pressed(_ sender: UIButton) {
        let facebookMangager = SocialMediaManager()
        facebookMangager.facebookSignup(self)
        facebookMangager.successBlock = { (response) -> Void in
            self.signInFacebook(response as! Dictionary)
        }
    }
    
    func signInFacebook(_ params: Dictionary<String, String>) {
        let email : String?
        email =  params["data[User][email]"]
        
        self.showAnimation()
        
            let loginParam =  [ kEmail                   :   email!,
                                kLatitude                : "\(DEVICE_LAT)" ,
                                kLongitude               : "\(DEVICE_LONG)"
                              ] as [String : Any]
            
        self.showAnimation()
        WebServiceManager.postWithOutHeader(params:loginParam as Dictionary<String, AnyObject> , serviceName: SOCIAL_LOGIN, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            self!.dismissLoadingView()
            if responseObj.status == true {
                
                UserDefaults.standard.set(responseObj.data?.user?.token , forKey: "user_token")
                //                UserDefaults.standard.set(responseObj.data?.user?.phoneNumber , forKey: "phoneNum")
                
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "KMainItemVC")
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)
    }
    
    @IBAction func btnGoogleSignIn_Pressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        }
        else {
            self.showAnimation()
            let email =     user.profile.email
            
            let loginParam =  [ kEmail                   : email!,
                                kLatitude                : "\(DEVICE_LAT)" ,
                                kLongitude               : "\(DEVICE_LONG)"
                              ] as [String : Any]

            WebServiceManager.postWithOutHeader(params:loginParam as Dictionary<String, AnyObject> , serviceName: SOCIAL_LOGIN, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
                let responseObj = response as! UserResponse
                self!.dismissLoadingView()
                if responseObj.status == true {
                    
                    UserDefaults.standard.set(responseObj.data?.user?.token , forKey: "user_token")
                    //                UserDefaults.standard.set(responseObj.data?.user?.phoneNumber , forKey: "phoneNum")
                    
                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(withIdentifier: "KMainItemVC")
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    UIApplication.shared.keyWindow?.rootViewController = nav
                }
                else {
                    self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
                }
                }, fail: { (error) in
                    self.dismissLoadingView()
                    
            }, showHUD: true)

            
                    
                    
            }
    
    }

    

}

extension KLoginVC: RegistrationDelegate {
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    func registrationDidSucceed(){
        
        
        var deviceToken =  UserDefaults.standard.value(forKey: "device_token") as? String
        
        if deviceToken == nil {
            deviceToken = "-1"
        }
        let loginParam =       [ kEmail         : txtEmail.text!,
                                 kPassword      : txtPassword.text! ,
                                 kLatitude      : "\(DEVICE_LAT)" ,
                                 kLongitude     : "\(DEVICE_LONG)"
            ] as [String : Any]
        
        self.showAnimation()
        WebServiceManager.postWithOutHeader(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            self!.dismissLoadingView()
            if responseObj.status == true {
                
                UserDefaults.standard.set(responseObj.data?.user?.token , forKey: "user_token")
//                UserDefaults.standard.set(responseObj.data?.user?.phoneNumber , forKey: "phoneNum")
                
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "KMainItemVC")
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                UIApplication.shared.keyWindow?.rootViewController = nav
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

extension UIViewController: NVActivityIndicatorViewable  {
    func  showAnimation() {
        let size = CGSize(width: 80, height: 80)
        startAnimating(size, message: "", messageFont: nil, type:.ballClipRotatePulse , color: UIColor.white, padding: CGFloat(70), displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil, fadeInAnimation: nil)
    }
    
    func dismissLoadingView() {
        stopAnimating(nil)
    }
}
