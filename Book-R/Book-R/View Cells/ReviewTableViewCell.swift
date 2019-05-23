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
		RatingLabel?.text = "rating: " + String(Int(review.rating))
		reviewTextView?.text = "Review: " + review.comment
	}
	
	
	@IBOutlet var RatingLabel: UILabel!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var reviewTextView: UITextView!
	
	var review: Review? {
		didSet { setupViews() }
	}
	
}
