//
//  BookRTabBarController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

protocol APIControllerProtocol {
	var apiController: APIController? { get set }
}

class BookRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		for childViewController in children {
			if var childvc = childViewController as? APIControllerProtocol {
				childvc.apiController = apiController
			}
		}
	}
	
	let apiController = APIController()
}
	
	

	


