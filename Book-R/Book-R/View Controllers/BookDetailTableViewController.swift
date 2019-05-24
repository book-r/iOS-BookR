//
//  BookDetailTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class BookDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	@IBAction func DoneButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return structLabel.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailCell", for: indexPath)
		cell.textLabel?.text = structLabel[indexPath.row]
		cell.detailTextLabel?.text = structValues?[indexPath.row]
		return cell
	}
	
	var bookDetail: BookDetail?
	var structValues: [String]?
	var structLabel = ["Title", "ISBN", "cover_url", "Description", "Edition", "Publisher"]// "Year", "Publisher ID", "Publisher", "Average", "Author"]


}
