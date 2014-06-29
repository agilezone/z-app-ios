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
    var clickedDelegate: WidgetIsClickedProtocol?
    let widgetHeight : CGFloat = 200

    func compile () {
        self.backgroundImageView = UIImageView(frame: CGRectMake(0, 0, 320, 200))
        self.addSubview(self.backgroundImageView)

        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidTouch")
        self.addGestureRecognizer(tapGesture)
        backgroundImageView!.sd_setImageWithURL(NSURL(string: "https://i1.ytimg.com/vi/0xQ3y902DEQ/maxresdefault.jpg"))
    }
    
    func update() {
        
    }
    
    func viewDidTouch () {
        println("Did Touch")
        
        //Menu split, expand split menu
        clickedDelegate?.widgetIsClicked(self)
    }
    
}