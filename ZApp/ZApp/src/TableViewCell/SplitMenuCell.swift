//
//  SplitMenu.swift
//  ZApp
//
//  Created by Numericable on 26/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation

class SplitMenuCell : UITableViewCell {
    
    var labelString:String?
    var label : UILabel?
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label = UILabel(frame: self.bounds)
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
    }
    
    func update() {
        label!.text = labelString
    }
    
}