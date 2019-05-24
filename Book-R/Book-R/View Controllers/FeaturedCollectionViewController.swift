//
//  SearchCollectionViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class FeaturedCollectionViewController: UICollectionViewController, APIControllerProtocol {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if apiController?.token == nil {
			performSegue(withIdentifier: "SignInSegue", sender: self)
		}
		
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
		
		if let count = apiController?.booksFeatured.count {
			return count
		}
		return 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionID", for: indexPath)
		guard let bookcell = cell as? BookCollectionViewCell,
			let book = apiController?.booksFeatured[indexPath.row],
			let image_data = book.image_data	else { return cell }
		
			bookcell.bookImageView.image = UIImage(data: image_data)

		return bookcell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SignInSegue" {
			guard let vc = segue.destination as? SignInSignUpViewController else { return }
			vc.apiController = apiController
			
		} else if segue.identifier == "CollectionToDetailSegue" {
			guard let vc = segue.destination as? BookDetailViewController,
				let cell = sender as? BookCollectionViewCell,
				let indexpath = collectionView.indexPath(for: cell) else { return }
			
			let book = apiController?.booksFeatured[indexpath.row]
			vc.apiController = apiController
//			vc.imageData = book?.cover_Image

			apiController?.fetchBookDetail(bookID: book!.id , completion: { result in
				if let bookDetail = try? result.get() {
					vc.bookDetail = bookDetail
				} else {
					print("error getting book Detail")
				}
			})
		}
	}
	
	var apiController: APIController?
	@IBOutlet var imageView: UIImageView!
}
