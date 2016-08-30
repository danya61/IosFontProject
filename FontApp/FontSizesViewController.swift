//
//  FontSisexViewController.swift
//  FontApp
//
//  Created by Danya on 18.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController{

    var Font : UIFont!
    
    private var pointSizes : [CGFloat] {
        struct Constants {
            static let pointSizes : [CGFloat] = [9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144]
        }
        return Constants.pointSizes
    }

    private let cellIdentifire = "FontNameAndSize"

    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont{
        let pointSize = pointSizes[indexPath.row]
        return Font.fontWithSize(pointSize)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pointSizes.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return pointSizes[indexPath.row] + 50
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = Font.fontName
        cell.detailTextLabel?.text = "\(pointSizes[indexPath.row]) point"
        
        return cell
    }
    
}
