//
//  BookmarksTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class BookmarksTableViewController: UITableViewController, APIControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("Bookkmark it")
		tableView.reloadData()
		print((apiController?.bookmarkedBooks.count)!)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return apiController?.bookmarkedBooks.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarksCell", for: indexPath)
		guard let bookmarkCell = cell as? BookMarksTableViewCell,
		let book = apiController?.bookmarkedBooks[indexPath.row],
		let data = book.image_data else { return cell }
		
		bookmarkCell.booklImageView.image = UIImage(data: data)
		return bookmarkCell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == UITableViewCell.EditingStyle.delete {
			let ac = UIAlertController(title: "Delete Bookmark?", message: "", preferredStyle: .actionSheet)
		
			ac.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
				self.apiController?.deleteBookFromBookMarks(index: indexPath.row)
				self.tableView.reloadData()
			}))
			ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
			present(ac, animated: true)
		}
	}
	
	var apiController: APIController?
}
