//
//  SplitMenuWidget.swift
//  ZApp
//
//  Created by Numericable on 26/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation

class SplitMenuWidget: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var tableDataSourceList : String[]?
    var tableView: UITableView?
    
    func compile() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, 320, 200))
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.addSubview(tableView)
        
        tableView!.layer.borderColor = UIColor.greenColor().CGColor
        tableView!.layer.borderWidth = 2
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func update() {
        self.tableView!.frame = CGRectMake(0, 0, 320, CGFloat(tableDataSourceList!.count) * 40)
        self.tableView!.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func cleanDataSourceList () {
        tableDataSourceList = String[]()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableDataSourceList!.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cellId = "splitMenuCell"
        
        var cell : SplitMenuCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? SplitMenuCell
        
        if cell == nil {
            cell = SplitMenuCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        
        println(tableDataSourceList![indexPath.row])
        
        cell!.labelString = tableDataSourceList![indexPath.row]
        cell!.update()
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        println("selected")
        
        
        self.update()
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40
    }
    
}