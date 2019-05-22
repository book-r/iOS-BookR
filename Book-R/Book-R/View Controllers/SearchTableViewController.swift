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
		
//		apiController?.fetchImage(with: book!.cover_url, completion: { result in
//			if let image = try? result.get() {
//				DispatchQueue.main.async {
//					bookcell.imageView?.image = image
//					self.tableView.reloadData()
//				}
//			}
//		})
		
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
