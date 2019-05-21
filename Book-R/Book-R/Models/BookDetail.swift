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
	let average: Int
	let edition: String
	let year: Int
	let publisher_id: Int
	let publisher: String
	
	let authors: [Author]
	let reviews: [Review]
}

struct Author: Codable, Equatable {
	
}


struct Review: Codable, Equatable {
}
