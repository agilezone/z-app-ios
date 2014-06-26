//
//  SplitMenuWidget.swift
//  ZApp
//
//  Created by Numericable on 26/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation

class SplitMenuWidget: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableDataSourceList : String[]?
    var tableView: UITableView?
    
    func compile() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, 320, 200))
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.addSubview(tableView)
        
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func update() {
        println("3rd element: \(tableDataSourceList![2])" )
        self.tableView!.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println("nums: \(tableDataSourceList!.count)" )
        return tableDataSourceList!.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cellId = "splitMenuCell"
        
        var cell : SplitMenuCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? SplitMenuCell
        
        if cell == nil {
            cell = SplitMenuCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        
        cell!.labelString = tableDataSourceList![indexPath.row]
        cell!.update()
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        println("selected")
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40
    }
    
}