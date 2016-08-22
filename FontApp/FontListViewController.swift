//
//  FontListViewController.swift
//  FontApp
//
//  Created by Danya on 17.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {

    var fontNames : [String] = []
    var showsFavorites = false
    private var cellPointSize : CGFloat!
    private let cellIdentifier = "FontName"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showsFavorites{
            navigationItem.rightBarButtonItem = editButtonItem()
        }
        let prefferedTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = prefferedTableViewFont.pointSize
    }

    func fontForDisplay(atIndexPath indexPath : NSIndexPath) -> UIFont {
        let fontName  = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavorites{
            fontNames = FavoritesList.sharedFavoriteList.favorites
            tableView.reloadData()
        }
    }



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fontNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        FavoritesList.sharedFavoriteList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavoritesList.sharedFavoriteList.favorites
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes"{
            let sizeVC = segue.destinationViewController as! FontSizesViewController
            sizeVC.navigationItem.title = "Sizes"
            sizeVC.Font = font
        } else {
            let infoVC = segue.destinationViewController as! FontInfoViewCotroller
            infoVC.font = font
            infoVC.favorite = FavoritesList.sharedFavoriteList.favorites.contains(font.fontName)
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showsFavorites
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if !showsFavorites {
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let favorite = fontNames[indexPath.row]
            FavoritesList.sharedFavoriteList.removeFvorite(favorite)
            fontNames = FavoritesList.sharedFavoriteList.favorites
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
