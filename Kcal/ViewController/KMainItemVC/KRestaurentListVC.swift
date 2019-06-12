//
//  KRestaurentListVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 23/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class KRestaurentListVC: UIViewController {
    
    @IBOutlet var tblView: UITableView!
    var restaurent : GetUserItemList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "MainItemCell", bundle: nil), forCellReuseIdentifier: "MainItemCell")

        // Do any additional setup after loading the view.
    }
    

   
}

extension KRestaurentListVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.restaurent?.restaurentInfo?.isEmpty == false {
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
        return (self.restaurent?.restaurentInfo?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainItemCell", for: indexPath) as? MainItemCell
        cell?.lblItemName.text = self.restaurent?.restaurentInfo![indexPath.row].name
        cell?.lblTime.text    = self.restaurent!.publishedAt
        cell?.lblSubTitle.text = self.restaurent?.restaurentInfo![indexPath.row].address
        cell?.lglNameOfApp.text = "k-cal"
        cell?.lblCalories.text = self.restaurent!.calaries
        
        guard  let imgeOfURL = self.restaurent?.restaurentInfo![indexPath.row].imageLink  else {
            
            return cell!
        }
        WAShareHelper.loadImage(urlstring: (imgeOfURL) , imageView: (cell?.imgOfItem)!, placeHolder: "placeholder")
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "KMainDetailInfoVC") as? KMainDetailInfoVC
        vc?.itemDetail = self.restaurent
        vc?.resutarentInfo = self.restaurent!.restaurentInfo![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  107.0
    }
}
