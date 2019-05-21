//
//  FavoritesTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self
	}

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "bookSerachCell", for: indexPath)
		
		return cell
	}
	
	
	@IBOutlet var searchBar: UISearchBar!
}


extension SearchTableViewController: UISearchBarDelegate  {
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		print(searchBar.text!)
	}
	
}
