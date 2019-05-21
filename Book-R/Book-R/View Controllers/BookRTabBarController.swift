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
		apiController.fetchBooks { error in
			if let error = error {
				print(error)
			}
		}
		
		
		for childVC in children {
			
		}
		
    }
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "" {
			guard let vc = segue.destination as? SignInSignUpViewController else { return }
			//send controller to sign in
			
		}
		
	}
	
	
	let apiController = APIController()
}
