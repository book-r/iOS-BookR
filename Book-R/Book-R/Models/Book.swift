//
//  Book.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
	let id: Int
	let title: String
	let isbn: String
	let cover_url: String
	let description: String
	let average: Double
	let edition: String
	let year: Int
	let publisher_id: Int
	let featured: Bool
}

struct BookReview: Codable {
	let rating: Double
	let comment: String
	let book_id: Int
	let user_id: Int
	
}
