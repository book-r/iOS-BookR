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

	@IBAction func doneButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
		
	}
	
	
	var apiController: APIController?
	
}
