//
//  GSEditProfileVC.swift
//  GARAGE SALE
//
//  Created by Ahmed Durrani on 29/01/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class GSEditProfileVC: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var imgOfProfile: UIImageView!
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var btnSave : UIButton!
    var userInfo : UserProfileInfo?
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSave.layer.shadowOpacity = 0.5
        btnSave.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSave.layer.shadowRadius = 5.0
        btnSave.layer.shadowColor = UIColor(red: 102/255.0 , green: 114/255.0 , blue: 228/255.0 , alpha: 1.0).cgColor
        lblEmail.text = userInfo?.email
        lblUserName.text = userInfo?.name
        txtUserName.text = userInfo?.name
        txtEmail.text = userInfo?.email

        txtPhoneNum.text = userInfo?.phoneNumber
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(GSEditProfileVC.imageTappedForDp(img:)))
        imgOfProfile.isUserInteractionEnabled = true
        imgOfProfile.addGestureRecognizer(tapGestureRecognizerforDp)

        guard  let image = userInfo?.profilePicture  else   {
            return imgOfProfile.image = UIImage(named: "profile2")
        }
        WAShareHelper.loadImage(urlstring: image, imageView: imgOfProfile, placeHolder: "profile2")
        let cgFloat: CGFloat = imgOfProfile!.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imgOfProfile, radius: CGFloat(someFloat))

        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) {[weak self] (orignal, edited) in
//
            
            self!.imgOfProfile.image = orignal
            let cgFloat: CGFloat = self!.imgOfProfile.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self!.imgOfProfile, radius: CGFloat(someFloat))
            self!.cover_image = orignal
            
            let params =      [ : ] as [String : Any]
            self!.showAnimation()
            
            WebServiceManager.multiPartImage(params: params as Dictionary<String, AnyObject> , serviceName: UPDATEPROFILE_PIC, imageParam:KImageParam, imgFileName: KImageFileName, serviceType: "Sign Up", profileImage: self!.imgOfProfile.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: {[weak self] (response) in
                self!.dismissLoadingView()
                
                let responseObj = response as! UserResponse
                if responseObj.status == true {
                    self?.showAlertViewWithTitle(title: KMessageTitle, message: responseObj.message!, dismissCompletion: {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KUPDATEPROFILE), object: nil, userInfo: nil)
                        
                    })

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

    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
        
        let params =      [ kEmail                     :  txtEmail.text!  ,
                            KFullName                  :  txtUserName.text! ,
                            KPhoneNum                  :  txtPhoneNum.text!
            
                        ] as [String : Any]
        self.showAnimation()
        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: UPDATEPROFILE, isLoaderShow: true, serviceType: "Update Profile", modelType: UserResponse.self, success: { [weak self] (response) in
            self!.dismissLoadingView()

            let  response = response as? UserResponse
            
            if response!.status == true {
                self?.showAlertViewWithTitle(title: KMessageTitle , message: (response?.message!)!, dismissCompletion: {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: KUPDATEPROFILE), object: nil, userInfo: nil)

                })
            }
            else {
                self!.showAlert(title: KMessageTitle , message: response!.message!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)

    }

    

}

