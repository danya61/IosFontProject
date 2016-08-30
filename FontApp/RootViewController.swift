//
//  RootViewController.swift
//  FontApp
//
//  Created by Danya on 12.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UISearchResultsUpdating{

    private var familyNames : [String]!
    private var cellPointSize : CGFloat!
    private var favoritesList : FavoritesList!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"
    var searchController = UISearchController(searchResultsController: nil)
    var filteredNames : [String] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        familyNames = UIFont.familyNames() as [String]
        familyNames.sortInPlace{return $0 < $1}
        let prefferedTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = prefferedTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Enter search"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont?{
        if indexPath.section == 0{
            let familyName = familyNames[indexPath.row]
            if let fontName = UIFont.fontNamesForFamilyName(familyName).first as String! {
                return UIFont(name: fontName, size: cellPointSize)
            } else{
                return nil}}
            else{
            return nil
        }
    }
    
    
    func updateSearchResultsForSearchController(searchController : UISearchController){
        let searchString = searchController.searchBar.text
        filteredNames.removeAll(keepCapacity: true)
        
        if !searchString!.isEmpty {
            let filter : String -> Bool = {name in
                
                let range = name.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range != nil
            }
            
            let matches = familyNames.filter(filter)
            filteredNames += matches
        }
        tableView.reloadData()
    }

    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if searchController.active && searchController.searchBar.text != "" {
                return filteredNames.count
            } else {
                return familyNames.count}
        } else {
           return 1 }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let strName : String
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell,forIndexPath: indexPath) as UITableViewCell
            if searchController.active && searchController.searchBar.text != "" {
                strName = filteredNames[indexPath.row]
            }
            else {
                strName = familyNames[indexPath.row]
            }
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = strName
            cell.detailTextLabel?.text = strName
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell,forIndexPath: indexPath) as UITableViewCell
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let listVC = segue.destinationViewController as! FontListViewController
        
        if indexPath.section == 0{
            let strName : String
            if searchController.active && searchController.searchBar.text != "" {
                strName = filteredNames[indexPath.row]
            } else {
                strName = familyNames[indexPath.row]
            }
            listVC.fontNames = UIFont.fontNamesForFamilyName(strName)
            listVC.fontNames.sortInPlace{return $0 < $1}
            listVC.navigationItem.title = "More Fonts"
            listVC.showsFavorites = false
        } else{
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showsFavorites = true
        }
    }
   
}
