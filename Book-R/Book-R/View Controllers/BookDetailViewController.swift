//
//  BookDetailViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		
		BookDetailOutlet.layer.cornerRadius = 8
		reviewOutlet.layer.cornerRadius = 8
		ExitOutlet.layer.cornerRadius = 8
		bookmarkOutlet.layer.cornerRadius = 8
    }
	
	private func isBookmarked() -> Bool {
		guard let book = book else { return  false}
		
		for bookmark in (apiController?.bookmarkedBooks)! {
			if book.id == bookmark.id {
				return true
			}
		}
		return false
	}
	
	@IBAction func bookmarkBookButton(_ sender: Any) {
		if apiController?.token == nil {
			let ac = UIAlertController(title: "Error", message: "Please sig in or sign up!", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			present(ac, animated: true)
			return
		} else if isBookmarked() {
			let ac = UIAlertController(title: "Error", message: "Book is Bookmarked!", preferredStyle: .actionSheet)
			ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			present(ac, animated: true)
			return
		}
		
		
		
		let ac = UIAlertController(title: "BookMark This Book", message: nil, preferredStyle: .actionSheet)
		
		ac.addAction(UIAlertAction(title: "Bookmark", style: .default, handler: { action in
			guard let book = self.book, let data = book.image_data	else { return }
			self.apiController?.addtoBookMarks(id: book.id, cover_url: book.cover_url, image_data: data)
		}))
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		
		present(ac, animated: true)
		
	
		
	}
	
	@IBAction func exitButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	private func setupViews() {
		guard let book = book else { return }

		DispatchQueue.main.async {
			self.titleLabel?.text = book.title
			self.descriptiontextView?.text = book.description
			self.bookImageView?.image = UIImage(data: book.image_data!)
			self.byLabel?.text = "by: " + self.setAuthor(authors: book.authors!)
			self.ratingLabel?.text = "Average Rating: \(String(Int(book.average ?? 0)))"
		}
	}
	
	func setAuthor(authors: [Author]) -> String{
		var namesStr = ""
		
		for author in authors {
			namesStr += "\(author.name), "
		}
		return namesStr
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if segue.identifier == "bookDetailSegue" {
			guard let vc = segue.destination as? BookDetailTableViewController else { return }
			vc.bookDetail = book
			vc.structValues = getDetail()
		} else if segue.identifier == "BookReviewsSegue" {
			guard let vc = segue.destination as? BookReviewsTableViewController else { return }
			vc.apiController = apiController
			vc.book_id = book?.id
		}
	}
	
	private func getDetail() -> [String]{
		guard let book = book else { return [] }
		let mirror = Mirror(reflecting: book)
		var structValues: [String] = []
		
		for child in mirror.children {
			if child.value is String {
				var str = ""
				str = child.value as! String
				structValues.append(str)
			}
		}
		
		return structValues
	}

	@IBOutlet var bookmarkOutlet: UIButton!
	@IBOutlet var BookDetailOutlet: UIButton!
	
	@IBOutlet var reviewOutlet: UIButton!
	
	@IBOutlet var ExitOutlet: UIButton!
	
	@IBOutlet var descriptiontextView: UITextView!
	@IBOutlet var rateThisBookLabel: UILabel!
	@IBOutlet var byLabel: UILabel!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var bookImageView: UIImageView!
	@IBOutlet var ratingLabel: UILabel!
	
	var imageData: Data?
	var apiController: APIController?
	var book: BookDetail? {
		didSet { setupViews() }
	}
	
}
