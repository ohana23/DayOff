//
//  ViewController.swift
//  DayOff
//
//  Created by Daniel Ohana on 8/9/18.
//  Copyright © 2018 Daniel Ohana. All rights reserved.
//
//  TODO: Change name strings to person objects

import UIKit

fileprivate let searchBarHeight = 40

struct Friend {
    let name: String
    var isActive: Bool
}

class ViewController: UITableViewController {
    
    let cellId = "cellId123123"
    
    /*
     By initializing UISearchController with a nil value for the
     searchResultsController, you tell the search controller that
     you want use the same view you’re searching to display the
     results. If you specify a different view controller here,
     that will be used to display the results instead.
    */
    let searchController = UISearchController(searchResultsController: nil)

    var allFriends = [
        Friend(name: "Eric", isActive: false),
        Friend(name: "Jane", isActive: false),
        Friend(name: "Mom", isActive: true),
        Friend(name: "Michael", isActive: true),
        Friend(name: "Dad", isActive: true)
    ]
    var filteredFriends = [Friend]()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Implement navigationController
        navigationItem.title = "Friends"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Implement searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search friends"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // We'll seperate the list into 2 sections: Active users and DayOff users
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredFriends.count
        }

        return allFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let friend: Friend
        if isFiltering() {
            friend = filteredFriends[indexPath.row]
        } else {
            friend = allFriends[indexPath.row]
        }
        
        cell.textLabel!.text = friend.name
        return cell
    }

    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredFriends = allFriends.filter({( friend : Friend) -> Bool in
            return friend.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

