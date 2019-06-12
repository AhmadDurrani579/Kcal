//
//  PinCustomCell.swift
//  Mobinp
//
//  Created by Ahmed Durrani on 04/12/2018.
//  Copyright © 2018 TRG. All rights reserved.
//

import UIKit


class PinCustomCell: UITableViewCell {
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//
//        addressOfThisEvent.addGestureRecognizer(tapGesture)

        // Initialization code
    }
    
    class func instanceFromNib() -> UITableViewCell {
        return UINib(nibName: "PinCustomCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! UITableViewCell
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
