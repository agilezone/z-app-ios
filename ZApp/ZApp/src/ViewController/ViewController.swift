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

