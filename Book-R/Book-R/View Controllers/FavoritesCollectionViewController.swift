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
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionID", for: indexPath)
		
		return cell
	}
	
	var apiController: APIController?
	@IBOutlet var imageView: UIImageView!
}
