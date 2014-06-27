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
    var homeWidgetList : Array<HomeBasicWidget> = HomeBasicWidget[]()
    let widgetHeight : CGFloat = 200
    let widegtWidth : CGFloat = 320
    var sectionList : String[] = ["Soldes", "Collection", "LookBook", "Pictures"]
    var productsStringList : String[] = ["Femme","Homme", "Enfants"]
    var splitMenu : SplitMenuWidget?
    
    override func viewDidLoad()  {
        //let atHome : Bool = true
        var productURl: String = ""
        let topBarHeight : CGFloat = 60
        let tabBarHeight : CGFloat = 40
        
        scrollView.frame = CGRectMake(0, topBarHeight, widegtWidth, self.view.frame.size.height - topBarHeight - tabBarHeight)
        self.view.addSubview(scrollView)
        
        /*
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
        */
        
        var error : NSError?
        
        var path = NSBundle.mainBundle().pathForResource("sampleData", ofType: "json")
        var jsonData = NSData.dataWithContentsOfFile(path, options: nil, error: &error)
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        let productsList : NSArray = jsonDict.objectForKey("products") as NSArray
        
        var proList = ZProduct[]()
        
        for product:AnyObject in productsList {
            var zProduct = ZProduct();
            let pro = product as NSDictionary

            zProduct.available_on = pro.objectForKey("available_on") as? String
            zProduct.price = pro.objectForKey("price") as? Int
            zProduct.shippingCategory = pro.objectForKey("shipping_category_id") as? Int
            zProduct.id = pro.objectForKey("id") as? Int
            zProduct.description = pro.objectForKey("description") as? String
            proList.append(zProduct);
            
        }
        var i:CGFloat = 0
        
        //Init Menu
        //splitMenu = SplitMenuWidget(frame: CGRectMake(0, widgetHeight, 320, CGFloat(productsStringList.count) * 40))
        splitMenu = SplitMenuWidget(frame: CGRectZero)
        splitMenu!.compile()
        splitMenu!.tableDataSourceList = productsStringList
        splitMenu!.update()
        self.scrollView.addSubview(splitMenu)
        //Initailly hidden
        splitMenu!.hidden = true
        
        for aString in sectionList {
            var aElement : HomeBasicWidget = HomeBasicWidget(frame: CGRectMake(0, i * widgetHeight, widegtWidth, widgetHeight))
            aElement.clickedDelegate = self
            homeWidgetList.append(aElement)
            scrollView.addSubview(aElement)
            i++;
        }
        scrollView.contentSize = CGSizeMake(widegtWidth, widgetHeight * i)
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func widgetIsClicked(widget : HomeBasicWidget)   {
        var shouldOpenWidget : Bool = false;
        var shouldCloseWidget : Bool = false;
        for homeWidgetElement : HomeBasicWidget in homeWidgetList {
            if shouldOpenWidget {
                var newFrame = homeWidgetElement.frame
                newFrame.origin.y += CGFloat(productsStringList.count * 40)
                UIView.animateWithDuration(0.5, animations: {homeWidgetElement.frame = newFrame})
            }
            
            if shouldCloseWidget {
                var newFrame = homeWidgetElement.frame
                newFrame.origin.y -= CGFloat(productsStringList.count * 40)
                UIView.animateWithDuration(0.5, animations: {homeWidgetElement.frame = newFrame})
            }
            
            if splitMenu!.hidden && widget.isEqual(homeWidgetElement){
                //change content size
                var menuHeight = CGFloat(productsStringList.count * 40)
                
                scrollView.contentSize = CGSizeMake(widegtWidth, CGFloat(sectionList.count) * widgetHeight + CGFloat(menuHeight))
                
                scrollView.setContentOffset(CGPointMake(0, widget.frame.origin.y), animated: true)
                splitMenu!.hidden = false
                splitMenu!.frame = CGRectMake(0, widget.frame.origin.y + widget.frame.size.height, widegtWidth, menuHeight)
                splitMenu!.update()
                shouldCloseWidget = false
                shouldOpenWidget = true
            }
            if !splitMenu!.hidden && widget.isEqual(homeWidgetElement) {
                var menuHeight = CGFloat(productsStringList.count * 40)
                
                scrollView.contentSize = CGSizeMake(widegtWidth, CGFloat(sectionList.count) * widgetHeight - CGFloat(menuHeight))
                
                scrollView.setContentOffset(CGPointMake(0, widget.frame.origin.y), animated: true)
                splitMenu!.hidden = false
                splitMenu!.frame = CGRectMake(0, widget.frame.origin.y + widget.frame.size.height, widegtWidth, 0)
                splitMenu!.update()
                shouldCloseWidget = true
                shouldOpenWidget = false
            }
            
        }
    }
}
