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
	let cover_url: String
	var image_data: Data?

}

struct BookReview: Codable {
	let rating: Double
	let comment: String
	let book_id: Int
	let user_id: Int
}

struct SendBookReview: Codable {
	let id: Int
	let title: String
	let username: String
	let book_id: Int
	let user_id: Int
	let rating: Double
	let comment: String
}
