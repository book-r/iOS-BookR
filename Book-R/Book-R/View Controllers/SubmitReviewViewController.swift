//
//  SubmitReviewViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SubmitReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupViews()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		setupViews()
	}
	
    
	@IBAction func starControlRatingValueChanged(_ sender: StarControl) {
		value = sender.value
	}
	
	@IBAction func submitButton(_ sender: Any) {
		print("submit")
		guard let reviewText = reviewTextView.text,
			let book_id = book_id,
			let token = apiController?.token else {
				
				print("No token")
				
				let ac = UIAlertController(title: "Error", message: "Please sig in or sign up!", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
				present(ac, animated: true)
				
				return
		}
	
		let bookReview = BookReview(rating: Double(value), comment: reviewText, book_id: book_id, user_id: token.id)
		
		apiController?.submitReview(with: token, review: bookReview, completion: { error in
			if let error = error {
				print("error submiting review: ",error)
				
				
			} else {
				self.dismiss(animated: true, completion: nil)
			}
		})
		
	}
	
	
	@IBAction func cancelButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	func setupViews() {
		
		guard let userName = apiController?.token?.username else { return }
		usernameLabel?.text = "Rate this book " + userName + "!"
	}
	
	private(set) var value = 0
	@IBOutlet var usernameLabel: UILabel!
	@IBOutlet var reviewTextView: UITextView!
	var apiController: APIController?
	var book_id: Int?
	
	
}
