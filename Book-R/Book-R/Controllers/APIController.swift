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


class APIController {
	
	init () {
		fetchBooks { (error) in
			if let error = error {
				print(error)
			}
		}
	}
	
	func signUp(with user: User, completion: @escaping (Error?) -> ()) {
		//"https://lambda-bookr.herokuapp.com/api/auth/register"
		let signUpUrl = URL(string: "https://lambda-bookr.herokuapp.com/api/auth/register")! //.appendingPathComponent("users/signup")
		
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
//				print(response)
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
			
			print(data)
			
			do{
				let decoder = JSONDecoder()
				let decodedData = try decoder.decode(SuccessResponse.self, from: data)
//				print(decodedData)
				
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
					let bookSave = BookSave(title: book.title, isbn: book.isbn, cover_Image: dataget, description: book.description)
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
	
	
	
}


