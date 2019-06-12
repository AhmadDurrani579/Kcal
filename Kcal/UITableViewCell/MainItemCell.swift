//
//  MainItemCell.swift
//  Kcal
//
//  Created by Ahmed Durrani on 14/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit

class MainItemCell: UITableViewCell {
    
    @IBOutlet weak var imgOfItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var lglNameOfApp: UILabel!
    
    @IBOutlet weak var lblCalories: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
