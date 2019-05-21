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
		tableView.reloadData()
	}

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return apiController?.books.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "bookSerachCell", for: indexPath)
		guard let bookcell = cell as? SearchTableViewCell else { return cell }
		
		let book = apiController?.books[indexPath.row]
		bookcell.book = book
		return bookcell
	}
	
	@IBOutlet var searchBar: UISearchBar!
	var apiController: APIController?
}


extension SearchTableViewController: UISearchBarDelegate  {
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		print(searchBar.text!)
	}
	
}
