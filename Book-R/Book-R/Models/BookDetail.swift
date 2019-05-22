//
//  BookDetail.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct BookDetail: Codable, Equatable {
	let id: Int
	let title: String
	let isbn: String
	var cover_url: String
	let description: String
	let edition: String
	let year: Int
	let publisher_id: Int
	let publisher: String
	let average: Double
	
	let authors: [Author]
//	let reviews: [Review]
}

struct Review: Codable, Equatable {
	let id: Int
	let rating: Int
	let comment: String
	let book_id: Int
	let user_id: Int
	let title: String
	let username: String
}

struct Author: Codable, Equatable {
	let id: Int
	let name: String
}


