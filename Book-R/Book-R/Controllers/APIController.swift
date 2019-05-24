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

class APIController {
	
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
				self.token = decodedData
				print(decodedData.token)
				
			} catch {
				print("error decoding token")
				completion(error)
			}
			completion(nil)
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
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let response = response as? HTTPURLResponse{
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

			do{
				let decoder = JSONDecoder()
				let decodedData = try decoder.decode(SuccessResponse.self, from: data)
				self.token = decodedData
				print(decodedData.token)
			} catch {
				print("error decoding token")
				completion(error)
			}
			
			completion(nil)
		}.resume()
		
	}
	
	func fetchFeaturedBooks(completion: @escaping (Error?) -> ()) {
		let url = URL(string: "https://lambda-bookr.herokuapp.com/api/books/?featured=true")!
		
		URLSession.shared.dataTask(with: url) { (data, _, error) in
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
				self.booksFeatured = booksDecoded
				self.fetchImageDataForBooks(books: self.booksFeatured)
				completion(nil)
			} catch {
				
				completion(error)
				return
			}
			
		}.resume()
	}

	func fetchBooks(completion: @escaping (Error?) -> ()) {
		URLSession.shared.dataTask(with: baseUrl) { (data, _, error) in
			if let error = error {
				completion(error)
				return
			}
			
			guard let data = data else {
				completion(NSError())
				return
			}
			
			do {
				let booksDecoded = try JSONDecoder().decode([BookDetail].self, from: data)
				self.booksAll = booksDecoded
				self.fetchImageDataForBooks(books: self.booksAll)
				print(booksDecoded.count)
				completion(nil)
			} catch {
				print("error gettinng booksAll: \(error)")
				completion(error)
				return
			}
			
		}.resume()
	}

	func fetchBookDetail(bookID: Int, completion: @escaping (Result<BookDetail, Error>) -> ()) {

		let url = baseUrl.appendingPathComponent(String(bookID))
		URLSession.shared.dataTask(with: url) { (data, _, error) in
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
				self.booksAll.append(bookDecoded)
				completion(.success(bookDecoded))
			} catch {
				completion(.failure(error))
				return
			}
		}.resume()
	}
	
	func fetchImageData(with url: String, completion: @escaping (Result<Data, Error>) -> ()){
		let imageurl = URL(string: url)!
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
	
	func fetchBookReviewDetail(bookID: Int, completion: @escaping (Result<[SendBookReview], Error>) -> ()) {
		let url = URL(string: "https://lambda-bookr.herokuapp.com/api/books/2/\(String(bookID))/reviews")
		
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
				let reviewsDecoded = try JSONDecoder().decode([SendBookReview].self, from: data)
	
				completion(.success(reviewsDecoded))
			} catch {
				completion(.failure(error))
				return
			}
			
			}.resume()
	}
	
	func submitReview(with token: SuccessResponse, review: BookReview, completion: @escaping (Error?) -> ()) {
		let url = URL(string: "https://lambda-bookr.herokuapp.com/api/reviews/")!
		
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue(token.token , forHTTPHeaderField: "Authorization")
		
		do {
			let encoder = JSONEncoder()
			let jsonData = try encoder.encode(review)
			request.httpBody = jsonData
		} catch {
			print("Error encoding review model: \(error)")
			completion(error)
		}
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let response = response as? HTTPURLResponse{
				print(response.statusCode)
				let nsError = NSError(domain: "", code: response.statusCode, userInfo: nil)
				completion(nsError)
			}

			if let error = error {
				completion(error)
			}
			
			completion(nil)
			}.resume()
		
	}
	
	init () {
		fetchFeaturedBooks { (error) in
			if let error = error {
				print("Error fetching books", error)
			}
		}
		
		fetchBooks { error in
			if let error = error {
				print("error fetching books from init \(error)")
			}
		}
		
	}
	
	var token: SuccessResponse?
	private let baseUrl = URL(string: "https://lambda-bookr.herokuapp.com/api/books")!
	private(set) var booksFeatured: [Book] = []
	private(set) var booksAll: [BookDetail] = []
	private(set) var bookmarkedBooks: [Book] = []
	
	
	private(set) var loggedInuser: User?
	private(set) var users: [User] = []
	
	private(set) var favoritBooks: FavoriteBooks?
	
	
	
}

extension APIController {
	private func fetchImageDataForBooks(books: [Book]) {
		for (index, book) in books.enumerated() {
			fetchImageData(with: book.cover_url) { result in
				if let result = try? result.get() {
					self.booksFeatured[index].image_data = result
				}
			}
		}
	}
	
	private func fetchImageDataForBooks(books: [BookDetail]) {
		for (index, book) in books.enumerated() {
			fetchImageData(with: book.cover_url) { result in
				if let result = try? result.get() {
					print(result)
					self.booksAll[index].image_data = result
				}
			}
		}
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
	
	
	
	//////////////////////////////////////
	//////////////////////////////////////
	
	func setFavorites(user: User) {
		favoritBooks = FavoriteBooks(user: user, books: [])
	}
	
	func addBookSaveToFavorites(book: BookSave) {
		favoritBooks?.books?.append(book)
	}
	
	//////////////////////////////////////
	//////////////////////////////////////
	
	func addtoBookMarks(id: Int, cover_url: String, image_data: Data) {
		let book = Book(id: id, cover_url: cover_url, image_data: image_data)
		bookmarkedBooks.append(book)
		print(bookmarkedBooks.count)
	}
	
	func deleteBookFromBookMarks(index: Int) {
		bookmarkedBooks.remove(at: index)
	}
	
}

