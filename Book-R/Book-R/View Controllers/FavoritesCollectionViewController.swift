//
//  SearchCollectionViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit



class FavoritesCollectionViewController: UICollectionViewController, APIControllerProtocol {

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
		
		let book = apiController?.books[indexPath.item]
		
		
		return bookcell
	}
	
	var apiController: APIController?
	@IBOutlet var imageView: UIImageView!
}
