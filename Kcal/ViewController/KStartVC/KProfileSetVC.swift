//
//  KProfileSetVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class KProfileSetVC: UIViewController {
    
    @IBOutlet weak var btnMale: UIButton!
    
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBOutlet weak var btnProfession: UIButton!
    @IBOutlet weak var btnLifeStyle: UIButton!
    var selectGender : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMale.isSelected = false
        selectGender = ""
        btnFemale.isSelected = false

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnMale_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnFemale.isSelected = false
        btnMale.isSelected = true
        selectGender = "male"
        
    }
    
    @IBAction func btnFemale_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnFemale.isSelected = true
        btnMale.isSelected = false
        selectGender = "female"

    }
    
    @IBAction func btnProfession_Pressed(_ sender: UIButton) {
        ActionSheetStringPicker.show(withTitle: KChoseCategory, rows: ["Engineer" , "Cricketer" , "Gym"] , initialSelection: 0 , doneBlock: {[weak self ] (picker, index, value) in
            self!.btnProfession.setTitle(value as? String , for: .normal)
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
            }, cancel: { (actionStrin ) in
                
        }, origin: sender)

    }
    
    @IBAction func btnLifeStyle_Pressed(_ sender: UIButton) {
        ActionSheetStringPicker.show(withTitle: KChoseCategory, rows: ["Sedate" , "Sporty" , "Domestic", "Deskjob" , "Manual job" , "Gym" , "Outdoor activities" , "Extreme Sports", "Winter Sports" , "Healthy" , "Calorie Conscious", "Clean Eater"] , initialSelection: 0 , doneBlock: {[weak self ] (picker, index, value) in
            self!.btnLifeStyle.setTitle(value as? String , for: .normal)
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
            }, cancel: { (actionStrin ) in
                
        }, origin: sender)

    }
    @IBAction func btnContinue_Pressed(_ sender: UIButton) {
//
        
        let profession = self.btnProfession.titleLabel?.text
        let style = self.btnLifeStyle.titleLabel?.text
        
        let params =      [ KGENDER                    :  selectGender!  ,
                            KAGE                       :  txtAge.text! ,
                            KHEIGHT                    :  txtHeight.text! ,
                            KWEIGHT                    :  txtWeight.text! ,
                            KPROFESSION                :  profession ?? " "  ,
                            KPLIFESTYLE                :  style!,
                            "address"                  : DEVICE_ADDRESS
            
            ] as [String : Any]
        self.showAnimation()
        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: ADDMOREINFO, isLoaderShow: true, serviceType: "More Info", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            self!.dismissLoadingView()
            if responseObj.status == true {
                self?.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KSETTRAVELINFO)
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)



        
    }
    
    
}
