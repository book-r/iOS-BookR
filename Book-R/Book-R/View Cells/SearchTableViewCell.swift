//
//  SearchTableViewCell.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, APIControllerProtocol {

	
	private func setupViews() {
		guard let book = book,
			let image_data = book.image_data else { return }
		
		titleLabel.text =  book.title
		isbnLabel.text = "isbn: " + book.isbn
		bookImageView.image = UIImage(data: image_data)

	}
	
	@IBOutlet var bookImageView: UIImageView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var isbnLabel: UILabel!
	var apiController: APIController?
	
	var book: BookDetail? {
		didSet { setupViews()}
	}
}
