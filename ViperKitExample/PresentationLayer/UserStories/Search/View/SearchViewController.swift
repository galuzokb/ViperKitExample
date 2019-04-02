//
//  SearchViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class SearchViewController: ViperKitExampleBaseTableViewController {
    var output: SearchViewOutput!
    var moduleInput: ModuleInput!
    
    var isSearching: Bool = false
    
    var displayManager: SearchDisplayManager!
    
    private var search: UISearchController?
    
    // MARK: Outlets
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: Public Methods
    
    public func hideSearch() {
        search?.dismiss(animated: false, completion: nil)
    }
}

// MARK: - View Input

extension SearchViewController: SearchViewInput {
    func setupInitialState() {
        displayManager = SearchDisplayManager(tableView: tableView)
        displayManager.delegate = self
        
        search = UISearchController(searchResultsController: nil)
        search?.searchBar.accessibilityLabel = "Search Search Bar"
//        search.searchResultsUpdater = self
        search?.dimsBackgroundDuringPresentation = false
        search?.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
//            search.searchResultsUpdater = self
        } else {
            // Fallback on earlier versions
            self.navigationItem.titleView = search?.searchBar
        }
    }
    
    func setPosts(_ posts: [Post]) {
        displayManager.setPosts(posts)
    }
    
    func setChangedPost(_ post: Post) {
        displayManager.setChangedPost(post)
    }
}

// MARK: - Module Input

extension SearchViewController: ModuleInputProvider {}

extension SearchViewController: SearchDisplayManagerDelegate {
    func postSelected(_ post: Post) {
        output.postSelected(post)
    }
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != nil && searchController.searchBar.text != "" {
            output.search(searchController.searchBar.text)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        dismissKeyboard()
        output.cancelSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        dismissKeyboard()
        output.search(searchBar.text)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}
