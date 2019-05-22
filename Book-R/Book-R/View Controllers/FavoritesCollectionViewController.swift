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
		
		collectionView.reloadData()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//performSegue(withIdentifier: "SignInSegue", sender: nil)
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return apiController?.books.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionID", for: indexPath)
		guard let bookcell = cell as? BookCollectionViewCell else { return cell }
		
		if let book = apiController?.bookSaves[indexPath.item] {
			bookcell.bookImageView.image = UIImage(data: book.cover_Image)
		}
		
		return bookcell
	}
	
	var apiController: APIController?
	@IBOutlet var imageView: UIImageView!
}
