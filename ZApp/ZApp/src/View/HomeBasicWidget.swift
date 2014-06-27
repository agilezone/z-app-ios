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

class HomeBasicWidget : UIView {
    
    var backgroundImageView : UIImageView = UIImageView()
    var clickedDelegate: WidgetIsClickedProtocol?
    let widgetHeight : CGFloat = 200
    
    init(frame: CGRect)  {
        super.init(frame: frame)
        self.backgroundImageView.frame = self.bounds
        self.addSubview(self.backgroundImageView)
        compile();
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.redColor().CGColor
        
    }
    
    func compile () {
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidTouch")
        self.addGestureRecognizer(tapGesture)
        backgroundImageView.sd_setImageWithURL(NSURL(string: "https://i1.ytimg.com/vi/0xQ3y902DEQ/maxresdefault.jpg"))
    }
    
    func update() {
        
    }
    
    func viewDidTouch () {
        println("Did Touch")
        
        //Menu split, expand split menu
        clickedDelegate?.widgetIsClicked(self)
    }
    
}