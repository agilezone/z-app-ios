//
//  ViewController.swift
//  ZApp
//
//  Created by Numericable on 17/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let manager = AFHTTPRequestOperationManager();
        manager.GET("http://192.168.0.32:3000/api/products?token=4f751e4e4f773a9611dd62f051d7a99cb1aa75a78dea79a7", parameters: nil, success: {
            (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
            println("JSON: " + responseObject.description)
            
            if let dict = responseObject as? NSDictionary {
                let count : AnyObject? = dict["count"]
                let currentPage : AnyObject? = dict["current_page"]
                let pages :AnyObject? = dict["pages"]
                let per_page : AnyObject? = dict["per_page"]
                
                
                
            }
            
            }, failure: {(operation: AFHTTPRequestOperation!,error: NSError!) in
            println("Error: " + error.localizedDescription)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

