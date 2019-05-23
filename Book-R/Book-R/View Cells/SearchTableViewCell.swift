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
		guard let book = book else { return }
		
		titleLabel.text =  book.title
		isbnLabel.text = "isbn: " + book.isbn
		
		if let image = UIImage(data: book.cover_Image) {
			bookImageView.image = image
			
		} else {
			print("No Image!!")
			bookImageView.image = #imageLiteral(resourceName: "temp_bkCover")
		}
	}
	
	@IBOutlet var bookImageView: UIImageView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var isbnLabel: UILabel!
	var apiController: APIController?
	
	var book: BookSave? {
		didSet { setupViews()}
	}
}
