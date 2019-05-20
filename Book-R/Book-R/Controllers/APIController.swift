//
//  NetworkController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
	case get = "GET"
	case post = "Post"
}



class APIController {
	
	
	
	
	
	func signIn(with user: User, completion: @escaping (Error?) -> ()) {
		// CHECK DOCS
		let url = baseUrl?.appendingPathComponent("users/login")
		
		var request = URLRequest(url: url!)
		request.httpMethod = HTTPMethod.post.rawValue
		
		//encode to json
		let encoder = JSONEncoder()
		do {
			let jsonData = try encoder.encode(user)
			request.httpBody = jsonData
		} catch {
			print("Error encoding user model: \(error)")
			completion(error)
		}
		
		// make urlsession
		
	}
	
	private let baseUrl = URL(string: "")
}
