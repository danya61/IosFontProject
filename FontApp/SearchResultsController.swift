//
//  SearchResultsControllerTableViewController.swift
//  FontApp
//
//  Created by Danya on 25.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class SearchResultsControllerTableViewController: UITableViewController,UISearchResultsUpdating {
    
    let FamName = "FamilyName"
    var familyNames : [String] = []
    var filteredNames : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: FamName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
