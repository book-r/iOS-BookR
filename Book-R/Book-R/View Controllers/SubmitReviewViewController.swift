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
		
	}
	
	@IBAction func submitButton(_ sender: Any) {
	}
	
	
	@IBAction func cancelButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	func setupViews() {
		
		guard let userName = apiController?.token?.username else { return }
		bookTitleLabel?.text = "Rate this book " + userName + "!"
	}
	
	
	@IBOutlet var bookTitleLabel: UILabel!
	@IBOutlet var reviewTextView: UITextView!
	var apiController: APIController?
//	{
//		didSet { setupViews() }
//	}
//
	
}
