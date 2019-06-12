//
//  KSetTravelInfoVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class KSetTravelInfoVC: UIViewController {

    @IBOutlet weak var imgOfLeft: UIImageView!
    @IBOutlet weak var lblTitleOfLeft: UILabel!
    @IBOutlet weak var imgOfMainLeft: UIImageView!
    
    @IBOutlet weak var imgOfRight: UIImageView!
    @IBOutlet weak var lblTitleOfRight: UILabel!
    @IBOutlet weak var imgOfMainRight: UIImageView!
    var selectOption : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgOfLeft.image = UIImage(named: "Rectangle_Copy")
        imgOfRight.image = UIImage(named: "Rectangle")
        lblTitleOfLeft.text = "Car"
        lblTitleOfRight.text = "Walk"
        lblTitleOfLeft.textColor = UIColor.white
        lblTitleOfRight.textColor = UIColor(red: 253/255.0, green: 111/255.0, blue: 103/255.0, alpha: 1.0)
        imgOfMainLeft.image = UIImage(named: "car_white")
        imgOfMainRight.image = UIImage(named: "car_dark")
        selectOption = "Car"


        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLeft_Pressed(_ sender: UIButton) {
        selectOption = "Car"

        imgOfLeft.image = UIImage(named: "Rectangle_Copy")
        imgOfRight.image = UIImage(named: "Rectangle")
        lblTitleOfLeft.textColor = UIColor.white
        lblTitleOfRight.textColor = UIColor(red: 253/255.0, green: 111/255.0, blue: 103/255.0, alpha: 1.0)
        imgOfMainLeft.image = UIImage(named: "car_white")
        imgOfMainRight.image = UIImage(named: "car_dark")

    }
    
    @IBAction func btnRight_Pressed(_ sender: UIButton) {
        selectOption = "Walk"

        imgOfRight.image = UIImage(named: "Rectangle_Copy")
        imgOfLeft.image  = UIImage(named: "Rectangle")
        lblTitleOfRight.textColor = UIColor.white
        lblTitleOfLeft.textColor = UIColor(red: 253/255.0, green: 111/255.0, blue: 103/255.0, alpha: 1.0)
        imgOfMainLeft.image = UIImage(named: "car_dark")
        imgOfMainRight.image = UIImage(named: "car_white")

    }
    
    @IBAction func btnContinue_Pressed(_ sender: UIButton) {
        let loginParam =       [ KTRAVEL_INFO         : selectOption! ,
                                ] as [String : Any]
        
        self.showAnimation()
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: TRAVEL_INFO, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            self!.dismissLoadingView()
            if responseObj.status == true {
                self?.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.kSETALLOW)
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)

    }

}
