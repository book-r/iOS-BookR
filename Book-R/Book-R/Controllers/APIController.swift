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
	
	
	
	func signUn(with user: User, completion: @escaping (Error?) -> ()) {
		
	}
	
	func signIn(with user: User, completion: @escaping (Error?) -> ()) {
		// CHECK DOCS
		let url = baseUrl?.appendingPathComponent("users/login")
		
		var request = URLRequest(url: url!)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("applicaition/json", forHTTPHeaderField: "Content-Type")
		
		//encode to json
		do {
			let encoder = JSONEncoder()
			let jsonData = try encoder.encode(user)
			request.httpBody = jsonData
		} catch {
			print("Error encoding user model: \(error)")
			completion(error)
		}
		
		// make urlsession
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				
				let nsError = NSError(domain: "", code: response.statusCode, userInfo: nil)
				completion(nsError)
			}
			
			if let error = error {
				completion(error)
			}
			
//			guard let data = data else {
//				completion(error)
//				return
//			}
//
//			do {
//				let decoder = JSONDecoder()
////				self.someModel = try decoder.decode(someMOdel.self, from: dats)
//			} catch {
//				print("error decoding some Object \(error)")
//				completion(error)
//				return
//			}
			
			completion(nil)
		}.resume()
		
	}
	
	func fetchBooks(completion: @escaping (Error?) -> ()) {
		
	}
	
	private let baseUrl = URL(string: "")
	private(set) var Books: [Book] = []
	
}



