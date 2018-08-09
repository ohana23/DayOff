//
//  ViewController.swift
//  DayOff
//
//  Created by Daniel Ohana on 8/9/18.
//  Copyright © 2018 Daniel Ohana. All rights reserved.
//
//  TODO: Change name strings to person objects

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "cellId123123"
    let dayOffFriends = ["Eric", "Jane"]
    let activeFriends = ["Mom", "Michael", "Dad"]
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Friends"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // View for header section
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        if section == 0 {
            label.text = "   Taking the day off"
        } else {
            label.text = "   Active"
        }
        
        return label
    }
    
    // We'll seperate the list into 2 sections: Active and DayOff Users
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    // Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dayOffFriends.count
        } else {
            return activeFriends.count
        }
    }
    
    // Cell for row at index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let name = indexPath.section == 0 ? dayOffFriends[indexPath.row] : activeFriends[indexPath.row]
        cell.textLabel?.text = name
        
        return cell
    }


}

