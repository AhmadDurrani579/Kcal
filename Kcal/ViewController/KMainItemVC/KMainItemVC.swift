//
//  KMainItemVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit
import RangeSeekSlider
import ActionSheetPicker_3_0
import GooglePlaces
import ListPlaceholder

class KMainItemVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var responseObj: UserResponse?
    var categoriesList: UserResponse?
    @IBOutlet weak var lblCountOfItem: UILabel!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnProfession: UIButton!
    @IBOutlet weak var distanceRange: RangeSeekSlider!
    @IBOutlet weak var priceRange: RangeSeekSlider!
    
    @IBOutlet weak var viewOfPop: UIView!
    var costRange : Int?
    var radiusRange : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
      WAShareHelper.setBorderAndCornerRadius(layer: txtLocation.layer, width: 0.3, radius: 4, color: UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnProfession.layer, width: 0.3, radius: 4, color: UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0))
        tblView.register(UINib(nibName: "MainItemCell", bundle: nil), forCellReuseIdentifier: "MainItemCell")
        priceRange.numberFormatter.positivePrefix = " £"
        distanceRange.numberFormatter.positiveSuffix = " kcals"
        distanceRange.delegate = self
        priceRange.delegate = self
        txtLocation.setLeftPaddingPoints(10)
        getAllitemList()
        // Do any additional setup after loading the view.
    }
    
    
    func getAllitemList() {
        
//        self.tblView.showLoader()
        self.showAnimation()
        let loginParam =         [ kLatitude      : "\(DEVICE_LAT)" ,
                                 kLongitude     : "\(DEVICE_LONG)"
            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLITEM, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            self!.dismissLoadingView()
            self!.responseObj = (response as! UserResponse)
            if self!.responseObj!.status == true {
                let countOfItem = self?.responseObj?.item?.count
                self!.lblCountOfItem.text = "\(countOfItem!)"
                self!.tblView.delegate = self
                self!.tblView.dataSource = self
//                self!.tblView.reloadData()
                
                self!.tblView.reloadData()



            }
            else {
                self!.showAlert(title: KMessageTitle , message: self!.responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)

    }

    @IBAction func btnProfile_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.pushViewController(vc! , animated: true)
    }

    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        viewOfPop.isHidden = true
    }
    
    @IBAction func btnChoseCategories_Pressed(_ sender: UIButton) {
       
        var allCategoriesList = [String]()
        for (_ , info) in (self.categoriesList?.categoriesList?.enumerated())! {
            allCategoriesList.append(info.name!)
        }
        ActionSheetStringPicker.show(withTitle: "Choose  Categories", rows: allCategoriesList , initialSelection: 0 , doneBlock: { (picker, index, value) in
            let category = self.categoriesList?.categoriesList![index]
            
            self.btnProfession.setTitle(category?.name , for: .normal)
//            self.idOfCategorie = category?.id
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)

    }
    
    @IBAction func btnApplyFilter_PressedOnItem(_ sender: UIButton) {
        let foodItem = self.btnProfession.titleLabel?.text
        self.showAnimation()
        let loginParam =       [ "price"        : "\(costRange!)" ,
                                 "category"     : foodItem! ,
                                 "latitude"     : "\(DEVICE_LAT)" ,
                                 "longitude"    : "\(DEVICE_LONG)" ,
                                 "distance"     : "\(radiusRange!)" ,
                                 "zipCode"      :  txtLocation.text!
                              ] as [String : Any]
        
         WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLFILTERITEM, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            self!.dismissLoadingView()
            self!.responseObj = (response as! UserResponse)
           if  self!.responseObj?.status == true {
             let countOfItem = self?.responseObj?.item?.count
            self!.lblCountOfItem.text = "\(countOfItem!)"
            self?.viewOfPop.isHidden = true
            self!.tblView.reloadData()
            }
            else {
            self?.showAlert(title: KMessageTitle, message: (self!.responseObj?.message)!, controller: self)
            }
            }, fail: { (error) in
                self.dismissLoadingView()
                
        }, showHUD: true)

    
    }
    
    @IBAction func btnApplyFilter_Pressed(_ sender: UIButton) {
        if categoriesList?.categoriesList == nil {
            self.showAnimation()
            WebServiceManager.get(params: nil, serviceName: GETITEMCATEGORIES , serviceType: "Item List", modelType: UserResponse.self, success: {[weak self] (response) in
                self!.dismissLoadingView()
                
                self!.categoriesList = (response as! UserResponse)
                if  self!.categoriesList?.status == true {
                    self?.viewOfPop.isHidden = false
                }
                else {
                    self?.showAlertViewWithTitle(title: KMessageTitle, message: (self?.categoriesList?.message!)!, dismissCompletion: {
                        self?.viewOfPop.isHidden = true
                    })
                }
            }) { (error) in
                self.dismissLoadingView()
            }
        } else {
            self.viewOfPop.isHidden = false
        }
    }
    
    @IBAction func destinationAddressAction_Pressed(_ sender: Any) {
//        txtDestinationAddress.resignFirstResponder()
//        let acController = GMSAutocompleteViewController()
//        acController.delegate = self
//        present(acController, animated: true, completion: nil)
    }

   
}

extension KMainItemVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.item?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no data."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.item?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainItemCell", for: indexPath) as? MainItemCell
//        cell?.contentView.showLoader()
        cell?.lblItemName.text = self.responseObj?.item![indexPath.row].name
        cell?.lblTime.text = self.responseObj?.item![indexPath.row].publishedAt
        cell?.lblSubTitle.text = self.responseObj?.item![indexPath.row].location
        cell?.lglNameOfApp.text = "k-cal"
        cell?.lblCalories.text = self.responseObj?.item![indexPath.row].calaries
       
        guard  let imgeOfURL = self.responseObj?.item![indexPath.row].ImageLink  else {
           
            return cell!
        }
        WAShareHelper.loadImage(urlstring: (imgeOfURL) , imageView: (cell?.imgOfItem)!, placeHolder: "placeholder")

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "KRestaurentListVC") as? KRestaurentListVC
        vc?.restaurent = self.responseObj?.item![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  107.0
    }
}

extension KMainItemVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
//        radius = Int(maxValue)
        
        if slider === distanceRange {
            radiusRange = Int(maxValue)
        
//            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        } else if slider === priceRange {
            costRange = Int(maxValue)
//            print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        //        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        //        print("did end touches")
    }
}

//extension KMainItemVC: GMSAutocompleteViewControllerDelegate {
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        // Get the place name from 'GMSAutocompleteViewController'
//        // Then display the name in textField
//
//        updateDEVICE_LAT = place.coordinate.latitude
//        updateDEVICE_LONG = place.coordinate.longitude
//        txtLocation.text = place.name
////        txtDestinationAddress.text = place.coordinate.latitude
//        // Dismiss the GMSAutocompleteViewController when something is selected
//        dismiss(animated: true, completion: nil)
//    }
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        // Handle the error
//        print("Error: ", error.localizedDescription)
//    }
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        // Dismiss when the user canceled the action
//        dismiss(animated: true, completion: nil)
//    }
//}

