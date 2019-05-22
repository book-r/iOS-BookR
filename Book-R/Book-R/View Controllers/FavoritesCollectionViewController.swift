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
		
		
		if apiController?.token == nil {

			performSegue(withIdentifier: "SignInSegue", sender: self)
		}

		collectionView.reloadData()
		
//		apiController?.fetchBooks { error in
//			if let error = error {
//				print(error)
//			}
//
//			DispatchQueue.main.async {
//				self.collectionView.reloadData()
//			}
//		}
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		collectionView.reloadData()
		
		
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
//		collectionView.reloadData()
		
		
		
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return apiController?.books.count ?? 0
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
			
		}
	}
	
	
	
	var apiController: APIController?
	@IBOutlet var imageView: UIImageView!
}
