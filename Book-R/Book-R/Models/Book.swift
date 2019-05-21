//
//  Book.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
	let title: String
	let isbn: String
	var image: Data
	
	
	init (title: String, isbn: String, image: Data) {
		self.title = title
		self.isbn = isbn
		self.image = image
	}
	
}
