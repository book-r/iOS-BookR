//
//  BookSaves.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


struct BookmarkedUser: Codable, Equatable {
	let username: String
	var books: [Book]
}
