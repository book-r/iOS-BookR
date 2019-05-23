//
//  SearchCollectionViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController, APIControllerProtocol {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
//		if apiController?.token == nil {
//			performSegue(withIdentifier: "SignInSegue", sender: self)
//		}
		
		collectionView.reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		collectionView.reloadData()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return favoriteBooks.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionID", for: indexPath)
		guard let bookcell = cell as? BookCollectionViewCell else { return cell }

		if let book = apiController?.bookSaves[indexPath.item] {
			bookcell.bookImageView.image = UIImage(data: book.cover_Image)
		} else {
			print("Not Set")
		}
		

		return bookcell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SignInSegue" {
			guard let vc = segue.destination as? SignInSignUpViewController else { return }
			vc.apiController = apiController
			
		} else if segue.identifier == "FavortieBookDetailSegue" {
			guard let vc = segue.destination as? FavoriteViewController else { return }
			vc.apiController = apiController
		}
	}
	
	func setBooks () {
		if let books = apiController?.bookSaves {
			favoriteBooks = books
			collectionView.reloadData()
		}
	}

	var apiController: APIController? {
		didSet { setBooks() }
	}
	
	var favoriteBooks: [BookSave] = []
	@IBOutlet var imageView: UIImageView!
}
