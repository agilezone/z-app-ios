//
//  HomeViewController.swift
//  ZApp
//
//  Created by Numericable on 25/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation

class HomeViewController : UIViewController, WidgetIsClickedProtocol {
    var scrollView : UIScrollView = UIScrollView(frame: CGRectZero)
    
    override func viewDidLoad()  {
        let atHome : Bool = false
        var productURl: String = ""
        let widgetHeight : CGFloat = 200
        let widegtWidth : CGFloat = 320
        
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        
        var sectionList : String[] = ["Soldes", "Collection", "LookBook", "Pictures"]
        
        if !atHome {
            productURl = "http://192.168.0.32:3000/api/products?token=4f751e4e4f773a9611dd62f051d7a99cb1aa75a78dea79a7"
        } else {
            productURl = "http://192.168.0.12:3000/api/products?token=fbc33ec2976f2c70b36a989dc28041f942f89e1e9c16eb56"
        }
        
        var error : NSError?
        var jsonError : NSError?
        var productUrl : NSURL = NSURL.URLWithString(productURl)
        let jsonData = NSData.dataWithContentsOfURL(productUrl, options: nil, error: &error)
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as NSDictionary
        
        var productsList : NSArray = jsonDict.objectForKey("products") as NSArray
        var proList = ZProduct[]()
        
        for product:AnyObject in productsList {
            var zProduct = ZProduct();
            let pro = product as NSDictionary
            zProduct.available_on = pro.objectForKey("available_on") as String
            zProduct.price = pro.objectForKey("price") as String
            zProduct.shippingCategory = pro.objectForKey("shipping_category_id") as Int
            zProduct.id = pro.objectForKey("id") as Int
            proList.append(zProduct);
        }
        var i:CGFloat = 0
        for aString in sectionList {
            var aElement : HomeBasicWidget = HomeBasicWidget(frame: CGRectMake(0, i * widgetHeight, widegtWidth, widgetHeight))
            scrollView.addSubview(aElement)
            i++;
        }
        scrollView.contentSize = CGSizeMake(widegtWidth, widgetHeight * i)
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func widgetIsClicked()  {
        
    }
}
