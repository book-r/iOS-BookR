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
	case post = "POST"
}

//henry - test
//Hector1234 - 1234

class APIController {
	
	init () {
		fetchBooks { (error) in
			if let error = error {
				print(error)
			}
		}
	}
	
	func signUp(with user: User, completion: @escaping (Error?) -> ()) {
		let signUpUrl = URL(string: "https://lambda-bookr.herokuapp.com/api/auth/register")!
		
		var request = URLRequest(url: signUpUrl)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do{
			let encoder = JSONEncoder()
			let encodedData = try encoder.encode(user)
			
			print(encodedData)
			request.httpBody = 	encodedData
		} catch {
			print("Error encoding user: ",error)
			completion(error)
		}
		print(request)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let response = response as? HTTPURLResponse,
				 response.statusCode != 201 {
				completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
				print("response error")
				return
			}
			
			if let error = error {
				completion(error)
				print(" error error")
				return
			}
			
			guard let data = data else {
				print("error with data")
				completion(nil)
				return
			}
			
			do{
				let decoder = JSONDecoder()
				let decodedData = try decoder.decode(SuccessResponse.self, from: data)
				
				self.token = decodedData.token
				print(decodedData.token)
				completion(nil)
			} catch {
				print("error decoding token")
				completion(error)
			}
			
		}.resume()
		
		
	}
	
	func signIn(with user: User, completion: @escaping (Error?) -> ()) {
		let url = URL(string: "https://lambda-bookr.herokuapp.com/api/auth/login")!
		
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
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
			if let response = response as? HTTPURLResponse{
//				response.statusCode != 200 {
				print(response.statusCode)
				let nsError = NSError(domain: "", code: response.statusCode, userInfo: nil)
				completion(nsError)
			}
			
			if let error = error {
				completion(error)
			}
			
			guard let data = data else {
				completion(error)
				return
			}
			

			print(data)
			do{
				let decoder = JSONDecoder()
				let decodedData = try decoder.decode(SuccessResponse.self, from: data)
				self.token = decodedData.token
				print(decodedData.token)
				completion(nil)
			} catch {
				print("error decoding token")
				completion(error)
			}
			
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
//				print(booksDecoded)
				
				for book in booksDecoded {
					self.createBookSave(book: book)
				}
				
				self.books = booksDecoded
				completion(nil)
			} catch {
				completion(error)
				return
			}
			
			}.resume()
	}
	
	func fetchBookDetail(bookID: Int, completion: @escaping (Result<BookDetail, Error>) -> ()) {
		
		let url = baseUrl?.appendingPathComponent(String(bookID))
		URLSession.shared.dataTask(with: url!) { (data, _, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				completion(.failure(NSError()))
				return
			}
			
			do {
				let bookDecoded = try JSONDecoder().decode(BookDetail.self, from: data)
//				print(bookDecoded)
				self.bookDetail.append(bookDecoded)
				
				
				
				completion(.success(bookDecoded))
			} catch {
				completion(.failure(error))
				return
			}
		}.resume()
	}
	
	func fetchImage(with isbn: String, completion: @escaping (Result<Data, Error>) -> ()){
		let imageurl = URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-M.jpg")!
		var request = URLRequest(url: imageurl)
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				print("Error Converting data to image.")
				completion(.failure(NSError()))
				return
			}
			
			completion(.success(data))
		}.resume()
	}
	
	func fetchBookReviewDetail(bookID: Int, completion: @escaping (Result<[Review], Error>) -> ()) {
		let url = URL(string: "https://lambda-bookr.herokuapp.com/api/reviews/\(String(bookID))")
		
		URLSession.shared.dataTask(with: url!) { (data, _, error) in
			if let error = error {
				completion(.failure(error))
				return    
			}
			
			guard let data = data else {
				completion(.failure(NSError()))
				return
			}
			
			do {
				let reviewsDecoded = try JSONDecoder().decode([Review].self, from: data)
	
				completion(.success(reviewsDecoded))
			} catch {
				completion(.failure(error))
				return
			}
			
			}.resume()
	}
	
	private let baseUrl = URL(string: "https://lambda-bookr.herokuapp.com/api/books/")
	private(set) var books: [Book] = []
	private(set) var bookDetail: [BookDetail] = []
	private(set) var bookSaves: [BookSave] = []
	
	
	var token: String?
	
	
	private(set) var loggedInuser: User?
	private(set) var users: [User] = []
	
	
}

extension APIController {
	private func createBookSave(book: Book) {
		
		fetchImage(with: book.isbn, completion: { result in
			if let dataget = try? result.get() {
//				DispatchQueue.main.async {
				let bookSave = BookSave(id: book.id, title: book.title, isbn: book.isbn, cover_Image: dataget, description: book.description)
					self.bookSaves.append(bookSave)
//				}
			}
		})
	}
	
	func createUser(username: String, password: String) {
		
		let user = User(username: username, password: password)
		loggedInuser = user
		users.append(user)
		
	}
	
	// return and array of the structs labels
	func mirrorStruct(book: BookDetail) -> [String] {
		var arr: [String] = []
		let mirror = Mirror(reflecting: book)
		
		for child in mirror.children {
			arr.append(child.label!)
		}
		
		
		return arr
	}
	
	
}


