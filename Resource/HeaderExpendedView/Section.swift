//
//  Section.swift
//  ExpendableView
//
//  Created by Ihsan ullah on 13/11/2018.
//  Copyright © 2018 htmlpro. All rights reserved.
//

import Foundation

struct Section {
    
    var genre: String
    var menuItem: [String]!
    var expanded:  Bool!
    
    init(genre: String, movie:[String], expanded: Bool) {
        self.genre = genre
        self.menuItem = movie
        self.expanded = expanded
    }
}


