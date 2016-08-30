//
//  SearchResultsControllerTableViewController.swift
//  FontApp
//
//  Created by Danya on 25.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit


private let longName = 6
private let shortNameButInd = 1
private let longNameButInd = 2

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    
    let FamName = "FamilyName"
    var familyNames : [String] = []
    var filteredNames : [String] = []
    private var favoritesList : FavoritesList!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: FamName)
    }
    
    
    //MARK: UISearchResultsUpdating Conformance
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
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredNames.count
    }

    
    
    override func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(FamName)! as UITableViewCell
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
    }

 
    
}
