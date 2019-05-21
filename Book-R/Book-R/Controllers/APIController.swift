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
		URLSession.shared.dataTask(with: baseUrl!) { (data, _, error) in
			if let error = error {
				completion(error)
				return
			}
			
			guard let data = data else {
				completion(NSError())
				return
			}
			
			do {
				let booksDecoded = try JSONDecoder().decode([Book].self, from: data)
				print(booksDecoded)
				self.books = booksDecoded
				completion(nil)
			} catch {
				completion(error)
				return
			}
			
			}.resume()
	}
	
	
	func fetchBookDetail(bookID: Int, completion: @escaping (Error?) -> ()) {
		URLSession.shared.dataTask(with: baseUrl!) { (data, _, error) in
			if let error = error {
				completion(error)
				return
			}
			
			guard let data = data else {
				completion(NSError())
				return
			}
			
			do {
				let bookDecoded = try JSONDecoder().decode(BookDetail.self, from: data)
				print(bookDecoded)
				self.bookDetail.append(bookDecoded)
				completion(nil)
			} catch {
				completion(error)
				return
			}
			
			}.resume()
	}
	
	func fetchImage(with url: String, completion: @escaping (Result<UIImage, Error>) -> ()){
		let imageurl = URL(string: url)!
		var request = URLRequest(url: imageurl)
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard 	let data = data,
				let image = UIImage(data: data) else {
					print("Error Converting data to image.")
					completion(.failure(NSError()))
					return
			}
			
			completion(.success(image))
			}.resume()
	}
	
	private let baseUrl = URL(string: "https://lambda-bookr.herokuapp.com/api/books/")
	private(set) var books: [Book] = []
	private(set) var bookDetail: [BookDetail] = []
	
}



