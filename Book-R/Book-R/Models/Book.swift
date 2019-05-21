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
	var cover_url: String
	let description: String
	let edition: String
	let year: Int
	let publisher_id: Int
	let publisher: String
}
