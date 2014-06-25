//
//  ViewController.swift
//  ZApp
//
//  Created by Numericable on 17/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let atHome : Bool = false
        var productURl: String = ""
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
        
        
                 /*
        let manager = AFHTTPRequestOperationManager();
        manager.GET(productURl, parameters: nil, success: {
            (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
            println("JSON: " + responseObject.description)
            
            var productsList = ZProduct[]();
            
           
            if let dict = responseObject as? NSDictionary {
                
                let count : AnyObject? = dict["count"]
                let currentPage : AnyObject? = dict["current_page"]
                let pages :AnyObject? = dict["pages"]
                let per_page : AnyObject? = dict["per_page"]
                
                let productsArray = dict["products"] as NSArray
                
                for product:AnyObject in productsArray {
                    
                    var zProduct = ZProduct();
                    
                    zProduct.available_on = product["available_on"] as String
                    
                    //zProduct.description = product["description"] as String
                   
                    productsList.append(zProduct);

                }


                
            }

            }, failure: {(operation: AFHTTPRequestOperation!,error: NSError!) in
            println("Error: " + error.localizedDescription)
            })
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

