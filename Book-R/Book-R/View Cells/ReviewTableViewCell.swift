//
//  ReviewTableViewCell.swift
//  Book-R
//
//  Created by Hector Steven on 5/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

	func setupViews() {
		guard let review = review else { return }

		nameLabel?.text = "user: " + review.username
		reviewTextView?.text = "review: " + review.comment
	}
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var reviewTextView: UITextView!
	
	var review: Review? {
		didSet { setupViews() }
	}
	
}
