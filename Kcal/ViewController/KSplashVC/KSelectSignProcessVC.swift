//
//  KSelectSignProcessVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 20/03/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit
import GoogleSignIn

class KSelectSignProcessVC: UIViewController , GIDSignInUIDelegate , GIDSignInDelegate  {
  
    @IBOutlet var imgOfSignUp: UIImageView!
    @IBOutlet weak var imgOfBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizerforDp1 = UITapGestureRecognizer(target:self, action:#selector(KSelectSignProcessVC.signUp_Pressed(img:)))
        imgOfSignUp.isUserInteractionEnabled = true
        imgOfSignUp.addGestureRecognizer(tapGestureRecognizerforDp1)
        GIDSignIn.sharedInstance().delegate = self

    }
    
    @IBAction func btnFacebook_Pressed(_ sender: UIButton) {
        let facebookMangager = SocialMediaManager()
        facebookMangager.facebookSignup(self)
        facebookMangager.successBlock = { (response) -> Void in
            self.signupWebservice(response as! Dictionary)
      }
    }
    
    func signupWebservice(_ params: Dictionary<String, String>) {
        let email : String?
        let firstName : String?
        let lastName  : String?
        let image : String?
        email =  params["data[User][email]"]
        image =  params["data[User][picture]"]
        
//        idOfFb =  params["data[User][facebook_id]"]
        firstName =  params["data[User][first_name]"]
        lastName  = params["data[User][last_name]"]

        self.showAnimation()
//        WAShareHelper.loadImage(urlstring: (image)! , imageView: (imgOfSignUp)!, placeHolder: "")
        let fullName = "\(firstName!) \(lastName!)"
        
        WAShareHelper.loadImageWithCompletion(urlstring: image!, showLoader: false, imageView: imgOfBackground) { (imageOfResult) in
            let loginParam =  [ kEmail                   : email!,
                                KFullName                : fullName,
                                KSIGNUPTYPE              : "facebook" ,
                                KDeviceType              : "iOS" ,
                                kLatitude                : "\(DEVICE_LAT)" ,
                                kLongitude               : "\(DEVICE_LONG)"
                
                ] as [String : Any]
            
            WebServiceManager.multiPartImageWithOutHeader(params: loginParam as Dictionary<String, AnyObject> , serviceName: SOCIALSIGNUP , imageParam:KImageParam, imgFileName: KImageFileName, serviceType: "Sign Up", profileImage: imageOfResult  , cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: {[weak self] (response) in
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
            if user.profile.hasImage
            {
                let pic = user.profile.imageURL(withDimension: 300)
            WAShareHelper.loadImageWithCompletion(urlstring: (pic?.absoluteString)!, showLoader: false, imageView: imgOfBackground) { (imageOfResult) in

                self.showAnimation()

                let fullName = "\(user.profile.name!)"
                let email =     user.profile.email


                
                let loginParam =  [ kEmail                   : email!,
                                    KFullName                : fullName,
                                    KSIGNUPTYPE              : "google" ,
                                    KDeviceType              : "iOS" ,
                                    kLatitude                : "\(DEVICE_LAT)" ,
                                    kLongitude               : "\(DEVICE_LONG)"
                    
                    ] as [String : Any]
                
                WebServiceManager.multiPartImageWithOutHeader(params: loginParam as Dictionary<String, AnyObject> , serviceName: SOCIALSIGNUP , imageParam:KImageParam, imgFileName: KImageFileName, serviceType: "Sign Up", profileImage: imageOfResult  , cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: {[weak self] (response) in
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
          }
        }
    }
   
    @objc func signUp_Pressed(img: AnyObject)
    {
        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KSignUpSelectionViewController)

    }
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
        pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KLoginViewController)

    }

   

}
