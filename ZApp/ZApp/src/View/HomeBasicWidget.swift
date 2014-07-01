//
//  HomeBasicWidget.swift
//  ZApp
//
//  Created by Numericable on 25/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation
import UIKit

protocol WidgetIsClickedProtocol {
    func widgetIsClicked(widget : HomeBasicWidget)
}

class HomeBasicWidget : UITableViewCell {
    
    var backgroundImageView : UIImageView?
    let widgetHeight : CGFloat = 200
    var homeComponent : HomeComponent?

    func compile () {
        self.backgroundImageView = UIImageView(frame: CGRectMake(0, 0, 320, widgetHeight))
        self.addSubview(self.backgroundImageView)

        //let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidTouch")
        //self.addGestureRecognizer(tapGesture)
        backgroundImageView!.sd_setImageWithURL(NSURL(string: "https://i1.ytimg.com/vi/0xQ3y902DEQ/maxresdefault.jpg"))
    }
    
    func update() {
        
    }
    
}