//
//  BookReviewsTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class BookReviewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		tableView.reloadData()
	}

	@IBAction func doneButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
		
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reviews?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCellID", for: indexPath)
		guard let reviewCell = cell as? ReviewTableViewCell else { return cell }
		
		
		reviewCell.review = reviews![indexPath.row]
		return reviewCell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "submitReviewSegue" {
			guard let vc = segue.destination as? SubmitReviewViewController,
				let book_id = book_id else { return }
			
			vc.apiController = apiController
			vc.book_id = book_id
		}
	}
	
	
	var apiController: APIController?
	var reviews: [Review]?
	var book_id: Int?
}
