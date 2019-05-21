//
//  BookRTabBarController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class BookRTabBarController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
//		for childVC in children {
//			if let vc = childVC as? controllerProtocal {
//				vc.controller = controller
//			}
//		}
		
    }
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "" {
			guard let vc = segue.destination as? SignInSignUpViewController else { return }
			//send controller to sign in
			
		}
		
	}
	
	

}
