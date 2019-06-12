//
//  KMainDetailInfoVC.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class KMainDetailInfoVC: UIViewController , GMSMapViewDelegate {

    @IBOutlet weak var viewOfMap: GMSMapView!
    
    @IBOutlet weak var imgOfItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblItemSubTitle: UILabel!
    
    @IBOutlet weak var lblCalories: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblHowCalories: UILabel!
    @IBOutlet weak var lblTimeReach: UILabel!
    @IBOutlet weak var lblMoreItem: UILabel!
    @IBOutlet weak var lblMoreItems1: UILabel!
    
    var bounds = GMSCoordinateBounds()
    var infoWindow = PinCustomCell(frame: CGRect(x: 0, y: 0, width: 90, height: 65))
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    var index:Int!

    var itemDetail : GetUserItemList?
    var resutarentInfo : RestaurentInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblItemName.text = resutarentInfo?.name
        lblTime.text = itemDetail?.publishedAt
        lblItemSubTitle.text = "M & S"
        lblCalories.text = itemDetail?.calaries
        lblAddress.text = resutarentInfo?.address
        
        let imgeOfURL = resutarentInfo!.imageLink
        WAShareHelper.loadImage(urlstring: (imgeOfURL!) , imageView: (imgOfItem)!, placeHolder: "placeholder")
        lblHowCalories.text = itemDetail?.calaries
        lblTimeReach.text  = itemDetail?.publishedAt
        lblMoreItem.text = "38 more items"
        lblMoreItems1.text = "20 more items"
        
        self.viewOfMap?.isMyLocationEnabled = true
        
        viewOfMap.tintColor = UIColor.red
        self.viewOfMap.settings.myLocationButton = true
        let mapInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0.0 , right: 0.0)
        self.viewOfMap.padding = mapInsets
        viewOfMap.delegate = self;
        
        self.viewOfMap.settings.compassButton = true
        self.viewOfMap.settings.zoomGestures = true
        self.viewOfMap.mapType = GMSMapViewType(rawValue: 3)!

        
        pinSetOnMap()
        
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { [weak self] placemarks, error in
//            guard let addressDict = placemarks?[0].addressDictionary else {
//                return
//            }
//
//            // Print each key-value pair in a new row
//            addressDict.forEach { print($0) }
//
//            // Print fully formatted address
//            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
//                //                    print(formattedAddress.joined(separator: ", "))
//                //                    self?.address = formattedAddress.joined(separator: ", ")
//
//
//
//            }
//        })
        

        // Do any additional setup after loading the view.
    }
    
    func pinSetOnMap() {
        
        let imageView = UIImageView()
        let marker = GMSMarker()
        
        var  lat : Double?
        var  lng : Double?
        
        
        if let latitude = itemDetail?.latitude! {
            
             lat = Double(latitude)
        }
        
        if let longitude = itemDetail?.longitude! {
            
            lng = Double(longitude)
        }


        let camera = GMSCameraPosition.camera(withLatitude: lat!  , longitude: lng! , zoom: 12.0)
        self.viewOfMap.camera = camera
        marker.accessibilityLabel = "\(index)"
        marker.position = CLLocationCoordinate2D(latitude: DEVICE_LAT, longitude:DEVICE_LONG)
        
        let markerImage = UIImage(named: "restaurant")!.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: markerImage)
        
        marker.icon = markerView.image
        self.bounds = self.bounds.includingCoordinate(marker.position)
        marker.map = self.viewOfMap
        let update = GMSCameraUpdate.fit(self.bounds, withPadding: 120.0)
        self.viewOfMap.animate(with: update)
        let cameras = GMSCameraPosition.camera(withLatitude: DEVICE_LAT , longitude: DEVICE_LONG , zoom: 12.0)
        self.viewOfMap.camera = cameras

    }
   

    @IBAction func btnNavigate_Pressed(_ sender: UIButton) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            
            var  lat : Double?
            var  lng : Double?
            
            
            if let latitude = resutarentInfo?.latitude! {
                
                lat = Double(latitude)
            }
            
            if let longitude = resutarentInfo?.longitude! {
                
                lng = Double(longitude)
            }
            

            UIApplication.shared.openURL((NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(lat!),\(lng!)&directionsmode=driving")! as URL) as URL)
        } else
        {
            NSLog("Can't use com.google.maps://");
        }

    }
    
    
    func loadNiB() -> PinCustomCell{
        let infoWindow = PinCustomCell.instanceFromNib() as! PinCustomCell
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if mapView.selectedMarker != nil
        {
            infoWindow.removeFromSuperview()
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        self.viewOfMap = nil
        
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        locationMarker = marker
        infoWindow.removeFromSuperview()
        infoWindow =  PinCustomCell(frame: CGRect(x: 0, y: 0, width: 90, height: 65))
        infoWindow = loadNiB()
        var point = mapView.projection.point(for: marker.position)
        point.y = point.y - 100
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
        
        guard let location = locationMarker?.position else {
            print("locationMarker is nil")
            return false
        }
//        infoWindow.center = mapView.projection.point(for: location)
//        infoWindow.center.y = infoWindow.center.y - sizeForOffset(view: infoWindow)
//        self.index = Int(marker.accessibilityLabel!)
        infoWindow.lblTime.text = itemDetail?.publishedAt
        let distance = itemDetail?.distance!
        infoWindow.lblDistance.text = "\(distance!) km"
        
        
        self.view.addSubview(self.infoWindow)
        return true
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            guard let location = locationMarker?.position else {
                print("locationMarker is nil")
                return
            }
            
            infoWindow.center = mapView.projection.point(for: location)
            infoWindow.center.y = infoWindow.center.y - sizeForOffset(view: self.infoWindow)
        }
    }
    
    
    func sizeForOffset(view: UIView) -> CGFloat {
        return  80.0
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }

}

