//
//  ProfileVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 18/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSearches: UILabel!
    
    @IBOutlet weak var lblVisited: UILabel!
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileVC.updateProfile(_:)), name: NSNotification.Name(rawValue: KUPDATEPROFILE), object: nil)

        getUserProfile()
        // Do any additional setup after loading the view.
    }
    
    @objc func updateProfile(_ notification: NSNotification) {
        getUserProfile()
    }

    
    func getUserProfile() {
        
        self.showAnimation()
        WebServiceManager.get(params: nil, serviceName: USERPROFILE , serviceType: "Profile", modelType: UserResponse.self, success: {[weak self] (response) in
            self!.dismissLoadingView()
            
            self!.responseObj = (response as! UserResponse)
            if  self!.responseObj?.status == true {
                
                self?.lblUserName.text = self?.responseObj?.profile?.name
                self?.lblAddress.text = self?.responseObj?.profile?.email
                
                guard  let image = self!.responseObj?.profile?.profilePicture  else   {
                    return (self?.profilePic.image = UIImage(named: ""))!
                }
                WAShareHelper.loadImage(urlstring:image , imageView: ((self?.profilePic!)!), placeHolder: "profile2")
                let cgFloat: CGFloat = (self?.profilePic.frame.size.width)!/2.0
                let someFloat = Float(cgFloat)
                WAShareHelper.setViewCornerRadius((self?.profilePic)! , radius: CGFloat(someFloat))

                
//                self!.tblViewss.delegate = self
//                self!.tblViewss.dataSource = self
//                self!.tblViewss.reloadData()
            }
            else {
                
                
            }
        }) { (error) in
            self.dismissLoadingView()
        }
    }

    

    @IBAction func btnLocation_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnProfileSetting_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnAccountSetting_Pressed(_ sender: UIButton) {
        
    }
    @IBAction func btnAboutUs_Pressed(_ sender: UIButton) {
    }
    
    @IBAction func btnTermCondition_Pressed(_ sender: UIButton) {
    }
    
    
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "user_token")
        localUserData = nil
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    @IBAction func btnEdit_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GSEditProfileVC") as? GSEditProfileVC
        vc?.userInfo = responseObj?.profile
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
