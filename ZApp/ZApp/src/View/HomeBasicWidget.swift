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
    func widgetIsClicked()
}

class HomeBasicWidget : UIView {
    
    var backgroundImageView : UIImageView = UIImageView()
    var clickedDelegate: WidgetIsClickedProtocol?
    var splitMenu : SplitMenuWidget?
    var productsStringList : String[] = ["Femme","Homme", "Enfants"]
    
    init(frame: CGRect)  {
        super.init(frame: frame)
        self.backgroundImageView.frame = self.bounds
        self.addSubview(self.backgroundImageView)
        compile();
    }
    
    func compile () {
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidTouch")
        self.addGestureRecognizer(tapGesture)
        backgroundImageView.sd_setImageWithURL(NSURL(string: "https://i1.ytimg.com/vi/0xQ3y902DEQ/maxresdefault.jpg"))
        
        //Init Menu
        splitMenu = SplitMenuWidget(frame: CGRectMake(0, 50, 320, 100))
        splitMenu!.compile()
        splitMenu!.tableDataSourceList = productsStringList
        splitMenu!.update()
        self.addSubview(splitMenu)
    }
    
    func update() {
        
    }
    
    func viewDidTouch () {
        println("Did Touch")
        clickedDelegate?.widgetIsClicked()
        //Menu split
        
        productsStringList.append("Pantalon")
        productsStringList.append("fours")
        splitMenu!.tableDataSourceList = productsStringList
        splitMenu!.update()
    }
    
}