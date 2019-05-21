//
//  FavoritesTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		print(searchBar.text!)
	}
	
	@IBOutlet var searchBar: UISearchBar!
}
