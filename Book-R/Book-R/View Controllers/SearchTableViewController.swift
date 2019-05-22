//
//  FavoritesTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, APIControllerProtocol{

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		tableView.reloadData()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
//		apiController?.fetchBooks { error in
//			if let error = error {
//				print(error)
//			} else {
//				DispatchQueue.main.async {
//					self.tableView.reloadData()
//					
//				}
//				
//				
//			}
//			
//		}
		
		searchBar.delegate = self
		tableView.reloadData()
	}

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return apiController?.books.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "bookSerachCell", for: indexPath)
		guard let bookcell = cell as? SearchTableViewCell else { return cell }
		
		let book = apiController?.bookSaves[indexPath.row]
		bookcell.book = book
		bookcell.apiController = apiController
		
		return bookcell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "bookDetailSegue" {
			guard let vc = segue.destination as? BookDetailViewController,
				let cell = sender as? SearchTableViewCell,
				let indexpath = tableView.indexPath(for: cell) else { return }
			
			vc.book = apiController?.bookSaves[indexpath.row]
			
		}
	}
	
	
	@IBOutlet var searchBar: UISearchBar!
	var apiController: APIController?
}


extension SearchTableViewController: UISearchBarDelegate  {
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		print(searchBar.text!)
	}
	
}
